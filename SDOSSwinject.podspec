@version = "0.9.3"
Pod::Spec.new do |spec|
  spec.platform     = :ios, '9.0'
  spec.name         = 'SDOSSwinject'
  spec.authors      = 'SDOS'
  spec.version      = @version
  spec.license      = { :type => 'SDOS License' }
  spec.homepage     = 'https://svrgitpub.sdos.es/iOS/SDOSSwinject'
  spec.summary      = 'Librería para la generación de código de Swinject'
  spec.source       = { :git => "https://svrgitpub.sdos.es/iOS/SDOSSwinject.git", :tag => "v#{spec.version}" }

  spec.preserve_paths = "src/Scripts/*"
  spec.dependency 'Swinject', '~> 2.6'

end
