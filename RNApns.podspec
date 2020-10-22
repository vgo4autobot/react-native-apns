
Pod::Spec.new do |s|
  s.name         = "RNApns"
  s.version      = "1.0.0"
  s.summary      = "RNApns"
  s.description  = <<-DESC
                  RNApns
                   DESC
  s.homepage     = "https://github.com/vgo4autobot/react-native-apns"
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "author" => "author@domain.cn" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/eacbkk/react-native-apns.git", :tag => "master" }
  s.source_files  = "ios/**/*.{h,m}"
  s.requires_arc = true


  s.dependency "React"
  #s.dependency "others"

end

  
