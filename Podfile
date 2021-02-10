source 'https://cdn.cocoapods.org/'

use_frameworks!

platform :ios, '10.0'

inhibit_all_warnings!

# Tools
pod 'SwiftLint', '~> 0.42.0'

def autolayout_framework
    pod 'SnapKit', '~> 5.0.1'
end

def network_framework
    pod 'Moya', '~> 14.0.0' # required to do network request
end

target 'CommonWealth-Test' do
    network_framework
    autolayout_framework

    pod 'SwiftMessages', '~> 9.0.0'
end
