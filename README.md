Для парсинга данных я использовал OpenAPI Generator, что значительно сэкономило мне время и позволило распарсить большую часть JSON. Это также обеспечило гибкость для масштабирования логики приложения в будущем.

В качестве базы данных я использовал SwiftData, так как приложение разрабатывалось для устройств с iOS 17 и новее. Для работы с API применял async/await и Task, что позволило асинхронно загружать данные. Для сохранения данных в SwiftData использовал DispatchQueue.

Для загрузки и кэширования изображений применял фреймворк Kingfisher.

Для запуска приложения достаточно клонировать репозиторий. Если возникает ошибка с Kingfisher, попробуйте удалить эту зависимость и установить её заново.