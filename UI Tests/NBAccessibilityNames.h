/*
 *****************************************************************************
 * Copyright (C) 2005-2014 UC Mobile Limited. All Rights Reserved
 * File			: NBAccessibilityNames.h
 *
 * Description	: 小说所有AccessibilityLabel定义
 *
 * Author		: zengsq@ucweb.com
 *
 * History		: Creation, 14-10-8, zengsq@ucweb.com, Create the file
 ******************************************************************************
 **/

#ifndef UCWEB_NBAccessibilityNames_h
#define UCWEB_NBAccessibilityNames_h

// 基本规则:
// 1. 所有小说的AccessibilityLabel需要以"NB."开头
// 2. 使用级别的方式，不同的级别使用"."字符来分开，例如"NB.BookShelf.SettingButton"代表小说(NB)中书架(BookShelf)的设置按钮(SettingButton)
// 3. 注意级别不需要太多，尽量保持最多三层即可(包括nb.在内)，级别过多时可读性差，另外如果界面换了层次关系也不需要重新修改
// 4. 最后一个层级尽量带上一些后缀来代表它的视图类型，下面是一样典型例子：
//      Field : UITextField
//      Label : UITextLabel
//      Button: UIButton
//      View  : UIView
//      Bar   : UIToolBar
//      Window: UIWindow

// 小说书架
#define NBAccessibilityLabel_BookShelf_Search            @"NB.BookShelf.SearchField"    // 搜索输入框
#define NBAccessibilityLabel_BookShelf_Setting           @"NB.BookShelf.SettingButton"  // 设置界面

// 小说搜索界面
#define NBAccessibilityLabel_Search_cancel               @"NB.Search.CancelButton"      // 搜索界面的退出按钮
#define NBAccessibilityLabel_Search_clear                @"NB.Search.ClearButton"       // 搜索界面的清除文字按钮

// 小说书架设置界面


// 小说阅读器


// 小说阅读器设置面板


// 来源界面


// 目录界面
#define NBAccessibilityLabel_Catalogue_title                @"NB.Catalogue.title"       // 目录界面标题
#define NBAccessibilityLabel_Catalogue_back                 @"NB.Catalogue.back"        // 目录界面返回按钮
#define NBAccessibilityLabel_Catalogue_sort                 @"NB.Catalogue.sort"        // 目录界面排序按钮
#define NBAccessibilityLabel_Catalogue_refresh              @"NB.Catalogue.refresh"     // 目录界面刷新按钮
#define NBAccessibilityLabel_Catalogue_dragBack             @"NB.Catalogue.back"        // 目录界面拖动返回按钮
#define NBAccessibilityLabel_Catalogue_cacheBtn             @"NB.Catalogue.cacheBtn"    // 目录界面缓存按钮
#define NBAccessibilityLabel_Catalogue_cacheTitle           @"NB.Catalogue.cacheTitle"  // 目录界面缓存按钮文字
#define NBAccessibilityLabel_Catalogue_downLoadImg          @"NB.Catalogue.downLoadImg" // 目录界面缓存下载图片
#define NBAccessibilityLabel_Catalogue_cacheView            @"NB.Catalogue.cacheView"   // 目录界面缓存按钮视图





// 小说MonkeyTest
#define NBAccessibilityLabel_MonkeyTest_DataImport                @"NB.MonkeyTest.DataImport"     // 小说MonkeyTest数据导入指标器


#define NBAccessibilityLabel_Debug_Mode_Switch            @"Debug Mode"   // 目录界面缓存按钮视图
#define NBAccessibilityLabel_Clear_History_Button         @"Clear History"   // 目录界面缓存按钮视图
#define NBAccessibilityLabel_AlertView_Clear_Button         @"Clear"   // 目录界面缓存按钮视图

#define NBAccessibilityLabel_Setting_Button               @"Settings"   // 目录界面缓存按钮视图
#define NBAccessibilityLabel_Timer_Button               @"Timer"   // 目录界面缓存按钮视图












#endif
