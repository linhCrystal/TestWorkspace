platform :ios, '11.0'
workspace 'TestWorkspace.xcworkspace'

def firebase_pods
	pod 'Firebase/Core'
	pod 'Firebase/MLVision'
	pod 'Firebase/MLVisionBarcodeModel'
	pod 'Alamofire', '~> 4.8.0'
	pod 'GooglePlaces'
	pod 'GooglePlacePicker'
	pod 'GoogleMaps'
	pod 'PINRemoteImage'
	pod 'MaterialComponents'
end

# TestWorkspace App
target 'TestWorkspace' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for TestWorkspace
	firebase_pods

end

target 'TestWorkspaceTests' do
  inherit! :search_paths
  # Pods for testing
end

target 'TestWorkspaceUITests' do
  # Pods for testing
end

# Core
target 'Core' do
	project 'Core/Core.xcodeproj'
	use_frameworks!
end

# UI
target 'Feature' do
	project 'Feature/Feature.xcodeproj'
	use_frameworks!
	firebase_pods
end
