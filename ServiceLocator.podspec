Pod::Spec.new do |s|
    s.name = 'ServiceLocator'
    s.version = '1.0.0'
    s.license = 'MIT'
    s.summary = 'A screen capture framework'
    s.homepage = 'https://github.com/space-code/service-locator'
    s.authors = { 'Nikita Vasilev' => 'nv3212@gmail.com' }
    s.source = { :git => 'https://github.com/space-code/service-locator.git', :tag => s.version }
    s.documentation_url = 'https://github.com/space-code/service-locator'

    s.ios.deployment_target = '12.0'
    s.osx.deployment_target = '10.14'
    s.tvos.deployment_target = '12.0'
    s.watchos.deployment_target = '6.0'

    s.source_files = 'ServiceLocator/**/*.{h,m}'
end