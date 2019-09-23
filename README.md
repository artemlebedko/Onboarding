# Onboarding

![Swift 5.0+](https://img.shields.io/badge/Swift-5.0%2B-orange.svg)
![Platform iOS](https://img.shields.io/badge/Platform-iOS-blue.svg)
[![License](https://img.shields.io/cocoapods/l/Moran.svg?style=flat)](https://cocoapods.org/pods/Moran)


## Overview
![Onboarding demo](https://github.com/artemlebedko/Onboarding/blob/master/onboarding_demo.gif)


### Elements

В проекте используется простой ```UICollectionView``` с кастомными ячейками. Управление элементами в ячейках, осуществляется через ```UIPanGestureRecognizer``` и в зависимости от того, сколько мы тянули экран/ячейку - элементы плавно передвигаются и в конце концов возвращаются в начальное положение.

![Custom elements](https://github.com/artemlebedko/Onboarding/blob/master/elements_demo.gif)

Секции переключаются автоматически, если пользователь ничего не нажимал. 



## Author

Artem Lebedko, artemlebedko@gmail.com



## License

Moran is available under the MIT license. See the LICENSE file for more info.
