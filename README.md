# flutter_douyin

flutter仿抖音练习项目，主要实现了上下滑动看视频，左右滑动，双击爱心以及评论输入框等功能，目前仅在安卓设备上测试过  

## 实现功能
- 上下滑动视频，视频未加载前，视频封面是一个大的抖音icon
- 支持下拉刷新，上拉无限加载
- 可拖动进度条，缓冲时候进度条会闪烁
- 使用preload_page_view实现预加载，默认预加载5个视频，可以通过修改参数指定预加载数量
- 右滑移动到个人中心页面，左滑移动到商城、关注等页面
- 查看评论，在评论弹出时，视频进行缩放往上顶，关闭评论时候恢复，根据弹出层动态调整视频大小
- 双击冒爱心，
- 评论输入，支持@人和字体表情

## 截图
<img src="https://raw.githubusercontent.com/lucis-yg/images/main/dy/1.png" alt="" width="200"><img src="https://raw.githubusercontent.com/lucis-yg/images/main/dy/2.png" alt="" width="200">
<img src="https://raw.githubusercontent.com/lucis-yg/images/main/dy/3.png" alt="" width="200">
<img src="https://raw.githubusercontent.com/lucis-yg/images/main/dy/4.png" alt="" width="200">
<img src="https://raw.githubusercontent.com/lucis-yg/images/main/dy/5.png" alt="" width="200">

## 依赖
  ### 解决pageview和tabview嵌套滑动问题
    nested_scroll_views: ^0.0.7
  ### 用于实现目前抖音最左图标点击时的页面移动效果
    flutter_zoom_drawer: ^3.0.4+1
  ### 视频预加载
    preload_page_view: ^0.1.6
  ### 视频播放相关组件
    video_player: ^2.6.1
    chewie: ^1.4.0
  ### 监听视频是否显示在屏幕上，主要用于视频的自动暂停与播放，
    visibility_detector: ^0.3.3
  ### 动画库，只在下拉刷新时候把刷新图标改成了lottie动画用到过一次
    lottie: ^2.3.2
  ### 自定义下拉刷新样式
    custom_refresh_indicator: ^2.0.1
  ### 字体大小调节
    flutter_screenutil: ^5.7.0
  ### 用于展示点赞、收藏时候的效果
    like_button: ^2.0.5
  ### 评论、分享转发以及输入框的弹出使用到的弹出框
    modal_bottom_sheet: ^3.0.0-pre
  ### 只在个人中心页的作品跳转到视频播放页用到
    get: ^4.6.5
  ### 在视频页左下角原创声音文字滚动用到
    bindings_compatible: ^1.0.1
  ### 主要用于实现@人功能
    extended_text_field: ^11.0.1

## 其他
目前只实现了一些基本功能，很多非功能逻辑性的代码没有分离出来而是写在了一起，在调试使用时候可以把不需要的视觉代码删除。


## 感谢
感谢依赖中所使用到的各类插件的作者们！
