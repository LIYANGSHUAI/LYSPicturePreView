Pod::Spec.new do |s|
s.name         = "LYSPicturePreView"
s.version      = "0.0.1"
s.summary      = "简单实现一个图片预览组件"
s.description  = <<-DESC
简单实现一个图片预览组件.简单实现一个图片预览组件
DESC
s.homepage     = "https://github.com/LIYANGSHUAI/LYSPicturePreView"

s.platform     = :ios, "8.0"
s.license      = "MIT"
s.author             = { "李阳帅" => "liyangshuai163@163.com" }

s.source       = { :git => "https://github.com/LIYANGSHUAI/LYSPicturePreView.git", :tag => s.version }

s.source_files  = "LYSPicturePreView", "LYSPicturePreView/*.{h,m}"
end
