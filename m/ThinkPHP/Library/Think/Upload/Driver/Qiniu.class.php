<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2013 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: yangweijie <yangweijiester@gmail.com> <http://www.code-tech.diandian.com>
// +----------------------------------------------------------------------

namespace Think\Upload\Driver;
use Think\Upload\Driver\Qiniu\QiniuStorage;


class Qiniu{
    /**
     * 上传文件根目录
     * @var string
     */
    private $rootPath;

    /**
     * 上传错误信息
     * @var string
     */
    private $error = '';

    private $config = array(
        'secrectKey'     => '', //七牛服务器
        'accessKey'      => '', //七牛用户
        'domain'         => '', //七牛密码
        'bucket'         => '', //空间名称
        'timeout'        => 300, //超时时间
    );

    /**
     * 构造函数，用于设置上传根路径
     * @param string $root   根目录
     * @param array  $config FTP配置
     */
    public function __construct($root, $config){
        $this->config = array_merge($this->config, $config);
        /* 设置根目录 */
        $this->qiniu = new QiniuStorage($config);
        $this->rootPath = trim($root, './') . '/';
    }

    /**
     * 检测上传根目录(七牛上传时支持自动创建目录，直接返回)
     * @return boolean true-检测通过，false-检测失败
     */
    public function checkRootPath(){
        return true;
    }

    /**
     * 检测上传目录(七牛上传时支持自动创建目录，直接返回)
     * @param  string $savepath 上传目录
     * @return boolean          检测结果，true-通过，false-失败
     */
    public function checkSavePath($savepath){
        return true;
    }

    /**
     * 创建文件夹 (七牛上传时支持自动创建目录，直接返回)
     * @param  string $savepath 目录名称
     * @return boolean          true-创建成功，false-创建失败
     */
    public function mkdir($savepath){
        return true;
    }

    /**
     * 保存指定文件
     * @param  array   $file    保存的文件信息
     * @param  boolean $replace 同名文件是否覆盖
     * @return boolean          保存状态，true-成功，false-失败
     */
    public function save(&$file, $replace = true)
    {

        //$file['name'] = $file['savepath'] . $file['savename'];
        $key = str_replace('/', '_', $file['qiniu_key']);

        $exts = array(
            'avi',
            'wmv',
            'mpeg',
            'mp4',
            'mov',
            'mkv',
            'flv',
            'f4v',
            'm4v',
            'rmvb',
            'rm',
            '3gp',
            'dat',
            'ts',
            'mts',
            'vob',
        );

        if (in_array($file['ext'], $exts)) {
            $key = str_replace('.' . $file['ext'], '.mp4', $key);
            $file['name'] =  str_replace('.' . $file['ext'], '.mp4', $file['name']);
            $file['savename'] =  str_replace('.' . $file['savename'], '.mp4', $key);
            $file['ext'] = 'mp4';
        }

        $upfile = array(
            'name' => 'file',
            'fileName' => $key,
            'fileBody' => file_get_contents($file['tmp_name'])
        );
        $config = array();
        //if (strpos($file['type'], 'video') !== false) {
        if (in_array($file['ext'], $exts)) {
            $config['persistentOps'] = 'avthumb/mp4|saveas/' . $this->urlsafe_base64_encode($this->config['bucket'] . ':' . $key);
        }


        $result = $this->qiniu->upload($config, $upfile, $replace);
        $url = $this->qiniu->downlink($key);

        if (isset($result['persistentId'])) {
            $file['persistentId'] = $result['persistentId'];
        }


        $file['url'] = $url;
        return false === $result ? false : true;
    }

    private function urlsafe_base64_encode($str)
    {
        $find = array("+", "/");
        $replace = array("-", "_");
        return str_replace($find, $replace, base64_encode($str));
    }


    /**
     * 获取最后一次上传错误信息
     * @return string 错误信息
     */
    public function getError(){
        return $this->qiniu->errorStr;
    }
    public function info($key){
        return $this->qiniu->info($key);
    }

}
