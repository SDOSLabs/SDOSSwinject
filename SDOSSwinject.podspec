@version = "1.2.0"
Pod::Spec.new do |spec|
  spec.platform     = :ios, '9.0'
  spec.name         = 'SDOSSwinject'
  spec.authors      = 'SDOS'
  spec.version      = @version
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/SDOSLabs/SDOSSwinject'
  spec.summary      = 'Librería para la generación de código de Swinject'
  spec.source       = { :git => "https://github.com/SDOSLabs/SDOSSwinject.git", :tag => "v#{spec.version}" }

  spec.preserve_paths = "src/Scripts/*"
  spec.dependency 'Swinject', '~> 2.6'

end
