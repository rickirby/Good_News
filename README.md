# Good News

## Description

Hi, I'm Ricki Bin Yamin. I would like to share my simple iOS Xcode Project.
Here is Good News. An apps that display weather information and some current news about covid-19.

This apps consumes information data from [openweathermap.org](https://openweathermap.org/) for weather and [newsapi.org](https://newsapi.org/) for covid-19 news.

## Technology Used

On building this apps, I use following technology

### MVVM-Coordinator Architecture
I implement Model-View-ViewModel for every segment information displayed in this apps. Coordinator was used to handle the navigation clearly. See how I manage it inside "Screen" folder which consists of "Home", "NewsList", and "Web".

### AsyncDisplayKit / Texture
I use [Texture](https://texturegroup.org/) to build the apps User interface. It is easier to handle the layout, thread-safe, and get smooth & responsive user interface.

### RxSwift
I take the advantage of Observable object in [RxSwift](https://github.com/ReactiveX/RxSwift) together implemented with URLSession and URLRequest to make an API call, instead of implementing Protocol-Delegate or completion handler closure. See my APIService class to see how I build for it. See also inside "Service" folder about the implementation of APIService class to make an API call, handle the request parameter, and also handle the response result. Every ViewModel should consume the Service class to trigger the API call and distribute the result on User Interface.

### Quick and Nimble
I would like to make my project more robust by Unit-Testing. I implement Quick and Nimble framework to do Unit Test. Just hit cmd + U, and see the test result and the coverage on every ViewModel class. The Service class should be mocked to prevent the Unit Test hit the real API. So, the Service-Interface-Protocol was created, and resulting Service class and MockService class who conforms its Interface-Protocol. Mocking the Service class also make the test coverage more reachable for any test condition.

### Shimmering / Skeleton
Waiting is boring, right? Making an API call can not be done instantly. It needs time to get the result. While waiting, skeleton view was popularly used in many apps. I implement [FBShimmering](https://github.com/facebookarchive/Shimmer) from facebook to create skeleton view while waiting the apps get the response result from the server.

### Pagination
List or table is the easiest way to display a lot of data. In this case, the number covid-19 news that was got from [newsapi.org](https://newsapi.org/) was a lot. Then I implemented pagination on the Table Node. On every API call, the apps only fetch 10 datas, then after the Table Node reach the bottom, it will fetch the next 10 datas and so on.

## How to Run this Apps

Simply clone or download this repository, open the .xcworkspace file, and hit cmd + R. You can also do the Unit Test by simply hitting cmd + U.
Run only on iPhone XR / iPhone 11 simulator / device (896 x 414)
Note: I pushed the Pod folder, so you don't need to pod install. Just clone/download, and use.

## Troubleshooting

If you get an error message on one or all of the section (weather and news), it may the API key has reach the daily limit of request, since it is only developer mode API key. Just try to open [newsapi.org](https://newsapi.org/) or [openweathermap.org](https://openweathermap.org/), create your own account, copy your API key and paste it inside GoodNewsConstant class (openWeatherKey or newsApiKey). Then re-build the apps.

## References
1. [Udemy - Mastering RxSwift in iOS by Mohammad Azam](https://www.udemy.com/course/mastering-rxswift-in-ios/)
2. [Medium Article - Building Safe URL in Swift Using URLComponents and URLQueryItem by Alfian Losari](https://medium.com/swift2go/building-safe-url-in-swift-using-urlcomponents-and-urlqueryitem-alfian-losari-510a7b1f3c7e)
3. [Github Gist - WebViewExampleViewController.swift by Felix M (fxm90)](https://gist.github.com/fxm90/50d6c73d07c4d9755981b9bb4c5ab931)
4. [StackOverflow - Can Swift convert a class / struct data into dictionary?](https://stackoverflow.com/questions/45209743/how-can-i-use-swift-s-codable-to-encode-into-a-dictionary)
5. My work experience that I've got from Apple Developer Academy @ UC & DANA Indonesia
