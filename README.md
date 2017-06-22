# HJImagePicker
图片选择器
使用photokit框架写的imagePicker 相比较之前的assetLibrary框架具有更强的功能

HJImagePicker 是为了应对图片多选场景开发的，但是在定制时候也考虑到单选情况
/**
 imagePicker  image  selcted type

 - HJImagePickerTpyeSingleSelection: chose singel image
 - HJImagePickerTypeMultiSelection: chose multi images
 */
typedef  NS_ENUM(NSInteger,HJImagePickerType){
    /**
     chose singel image
     */
    HJImagePickerTpyeSingleSelection = 0,
    
    /**
     chose multi images
     */
    HJImagePickerTypeMultiSelection = 1,
 
};
