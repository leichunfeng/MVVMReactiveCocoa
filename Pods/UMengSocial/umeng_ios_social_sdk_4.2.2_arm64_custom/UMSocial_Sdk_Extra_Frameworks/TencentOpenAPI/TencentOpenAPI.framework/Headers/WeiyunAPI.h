///
/// \file WeiyunAPI.h
/// \brief 提供微云平台相关接口的调用参数封装辅助类
///
/// Created by Tencent on 13-6-20.
/// Copyright (c) 2013年 Tencent. All rights reserved.
///

#ifndef QQ_OPEN_SDK_LITE

#import <Foundation/Foundation.h>
#import "sdkdef.h"


/** CGI请求上传数据回调协议 */
@protocol TCAPIRequestUploadDelegate <TCAPIRequestDelegate>

/**
 * 询问是否要开始上传数据
 * \param uploadRequest 对应的上传请求上下文
 * \param storageRequest 用于上传数据的NSURLRequest对象
 * \return 是否要开始上传数据，YES表示自动开始上传，NO表示不上传
 * \note 目前自动上传逻辑不支持断点续传机制，建议上传的数据不要太大
 */
- (BOOL)cgiUploadRequest:(TCAPIRequest *)uploadRequest shouldBeginUploadingStorageRequest:(NSURLRequest *)storageRequest;

@end


/** CGI请求下载数据回调协议 */
@protocol TCAPIRequestDownloadDelegate <TCAPIRequestDelegate>

/**
 * 询问是否要开始下载数据
 * \param downloadRequest 对应的下载请求上下文
 * \param storageRequest 用于下载数据的NSURLRequest对象
 * \return 是否要开始下载数据，YES表示自动开始下载，NO表示不下载
 * \note 目前自动下载逻辑不支持断点分块机制，建议下载的数据不要太大
 */
- (BOOL)cgiDownloadRequest:(TCAPIRequest *)downloadRequest shouldBeginDownloadingStorageRequest:(NSURLRequest *)storageRequest;

@end


/** 微云相关接口基类 */
@interface WeiYun_BaseRequest : TCAPIRequest

@end

#pragma mark - 照片相关
/**
 * \brief 申请上传照片
 *
 * 本接口用于申请上传照片；然后app用返回的存储平台url地址、端口等信息上传照片文件自身内容到存储平台
 * \note 是否需要APP申请API权限：是\n
 *       是否需要用户授权：是
 */
@interface WeiYun_upload_photo_GET : WeiYun_BaseRequest

/** 待上传文件SHA */
@property (nonatomic, retain) TCRequiredStr param_sha;

/** 待上传文件MD5 */
@property (nonatomic, retain) TCRequiredStr param_md5;

/** 待上传文件size字节 */
@property (nonatomic, retain) TCRequiredStr param_size;

/** 待上传文件名 */
@property (nonatomic, retain) TCRequiredStr param_name;

/** control|normal，默认control */
@property (nonatomic, retain) TCOptionalStr param_upload_type;

/** 需要上传的数据 */
@property (nonatomic, retain) TCRequiredData paramUploadData;

@end

/**
 * \brief 获取照片下载url地址
 *
 * 本接口用于获取照片下载信息；然后app用返回的存储平台url地址、端口等信息从存储平台下载文件内容
 * \note 是否需要APP申请API权限：是\n
 *       是否需要用户授权：是
 */
@interface WeiYun_download_photo_GET : WeiYun_BaseRequest

/** 待下载文件的ID，字符串（68字节） */
@property (nonatomic, retain) TCRequiredStr param_file_id;

@end

/**
 * \brief 获取照片列表
 *
 * 本接口用于获取app目录下照片列表，用分片的方式获取，每分片最多200个文件
 * \note 是否需要APP申请API权限：是\n
 *       是否需要用户授权：是
 */
@interface WeiYun_get_photo_list_GET : WeiYun_BaseRequest

/** 所有文件数目的偏移，从0开始计数 */
@property (nonatomic, retain) TCRequiredStr param_offset;

/** 请求文件的数量，取值1-200 */
@property (nonatomic, retain) TCRequiredStr param_number;

@end

/**
 * \brief 删除照片
 *
 * 本接口用于删除照片
 * \note 是否需要APP申请API权限：是\n
 *       是否需要用户授权：是
 */
@interface WeiYun_delete_photo_GET : WeiYun_BaseRequest

/** 待下载文件的ID，字符串（68字节） */
@property (nonatomic, retain) TCRequiredStr param_file_id;

@end

/**
 * \brief 获取照片缩略图下载地址
 *
 * 本接口用于获取照片缩略图下载URL地址；然后app用返回的存储平台url地址、端口等信息上下载照片文件内容
 * \note 是否需要APP申请API权限：是\n
 *       是否需要用户授权：是
 */
@interface WeiYun_get_photo_thumb_GET : WeiYun_download_photo_GET

/** 缩略图尺寸，目前支持四种类型: 1024*1024，640*640，128*128，64*64 */
@property (nonatomic, retain) TCRequiredStr param_thumb;

@end

#pragma mark - 视频相关
/**
 * \brief 申请上传视频
 *
 * 本接口用于申请上传视频；然后app用返回的存储平台url地址、端口等信息上传视频内容到存储平台
 * \note 是否需要APP申请API权限：是\n
 *       是否需要用户授权：是
 */
@interface WeiYun_upload_video_GET : WeiYun_upload_photo_GET;

@end


/**
 * \brief 获取视频下载url地址
 *
 * 本接口用于获取视频下载信息；然后app用返回的存储平台url地址、端口等信息从存储平台下载视频内容
 * \note 是否需要APP申请API权限：是\n
 *       是否需要用户授权：是
 */
@interface WeiYun_download_video_GET : WeiYun_download_photo_GET;

@end


/**
 * \brief 获取视频列表
 *
 * 本接口用于获取本app目录下视频列表，用分片的方式获取，每分片最多200个文件
 * \note 是否需要APP申请API权限：是\n
 *       是否需要用户授权：是
 */
@interface WeiYun_get_video_list_GET : WeiYun_get_photo_list_GET;

@end


/**
 * \brief 删除视频
 *
 * 本接口用于删除视频文件
 * \note 是否需要APP申请API权限：是\n
 *       是否需要用户授权：是
 */
@interface WeiYun_delete_video_GET : WeiYun_delete_photo_GET;

@end

#pragma mark - 音频相关
/**
 * \brief 申请上传音频
 *
 * 本接口用于申请上传音频；然后app用返回的存储平台url地址、端口等信息上传音频内容到存储平台
 * \note 是否需要APP申请API权限：是\n
 *       是否需要用户授权：是
 */
@interface WeiYun_upload_music_GET : WeiYun_upload_photo_GET;

@end


/**
 * \brief 获取音频下载url地址
 *
 * 本接口用于获取音频下载信息；然后app用返回的存储平台url地址、端口等信息从存储平台下载音频内容
 * \note 是否需要APP申请API权限：是\n
 *       是否需要用户授权：是
 */
@interface WeiYun_download_music_GET : WeiYun_download_photo_GET;

@end


/**
 * \brief 获取音频列表
 *
 * 本接口用于获取本app目录下视频列表，用分片的方式获取，每分片最多200个文件
 * \note 是否需要APP申请API权限：是\n
 *       是否需要用户授权：是
 */
@interface WeiYun_get_music_list_GET : WeiYun_get_photo_list_GET;

@end


/**
 * \brief 删除音频
 *
 * 本接口用于删除音频文件
 * \note 是否需要APP申请API权限：是\n
 *       是否需要用户授权：是
 */
@interface WeiYun_delete_music_GET : WeiYun_delete_photo_GET;

@end


#pragma mark - 结构化数据
/**
 * \brief 查询key所对应的键值对是否存在
 */
@interface WeiYun_check_record_GET : WeiYun_BaseRequest

/** KV键值对的key,十六进制编码,字符串（对应的二进制字符串不超过100字节）*/
@property (nonatomic, retain) TCRequiredStr param_key;

@end


/**
 * \brief 查询key所对应的键值对是否存在
 * \note  参数参照 \ref WeiYun_check_record_GET
 */
@interface WeiYun_delete_record_GET : WeiYun_check_record_GET

@end

/**
 * \brief 查询key所对应的键值对的value
 * \note  参数参照 \ref WeiYun_check_record_GET
 */
@interface WeiYun_get_record_GET : WeiYun_check_record_GET

@end

/**
 * \brief 创建key-value键值对
 */
@interface WeiYun_create_record_POST : WeiYun_BaseRequest

/** KV键值对的key，十六进制编码，字符串（对应的二进制串不超过100字节）*/
@property (nonatomic, retain)TCRequiredStr param_key;

/** KV键值对的value，十六进制编码，字符串（对应的二进制串不超过1M字节）*/
@property (nonatomic, retain)NSData *param_value;

@end


/**
 * \brief 修改key-value键值对的value为新值
 * \note  参数参照 \ref WeiYun_create_record_POST
 */
@interface WeiYun_modify_record_POST : WeiYun_create_record_POST


@end

/**
 * \brief 查询登录用户的全部key列表
 * \note  没有参数
 */
@interface WeiYun_query_all_record_GET : WeiYun_BaseRequest


@end

#endif


