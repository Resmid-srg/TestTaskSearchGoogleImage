# TestTaskSearchGoogleImage

Импортированные библиотеки через SPM:
- Alamofire
- SDWebImage
---
- Приложение реализовано на архитектуре MVVM, с использованием Storyboard
Остается возможность внедрения тестов

(Реализация MVC есть в моем большом приложении для знакомств кандидатов и HR :) https://github.com/Resmid-srg/Employder)

- Главный экран выполнен с использованием Compositional Layout 

- Для биндинга View и ViewModel реализован класс Dynamic

- Картинки на главном экране подгружаются сжатого формата, предоставляемого самим API, для оптимизации и экономии ресурсов
На полноэкранном режиме подгружается оригинальный размер.
Если ссылка на оригинал не поддерживает безопасный протокол https, показывается картинка со ссылкой на ее сжатый формат

- Внедрена анимация загрузки данных на главном экране, на странице полноэкранного режима картинки и на экране WebView. 
Учтена задержка начала анимации индикатора загрузки, для решении проблемы промигивания индикатора на быстро прогружаемых картинках
Также реализована анимация пролистывания картинок кнопками "Prev" и "Next"

- Поддержка темного режима

