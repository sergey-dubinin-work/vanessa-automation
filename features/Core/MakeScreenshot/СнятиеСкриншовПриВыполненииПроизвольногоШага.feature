﻿# language: ru

@IgnoreOnOFBuilds
@IgnoreOn82Builds
@IgnoreOnWeb
@tree

Функциональность: Снятие скриншов при выполнении произвольного шага

	
	Сценарий: Снятие скриншота при тегировании шага специальным тегом

		Дано Я открываю VanessaAutomation в режиме TestClient со стандартной библиотекой
		И я перехожу к закладке "Сервис"
		И я перехожу к закладке "Отчет о запуске сценариев"
		И     В открытой форме я устанавливаю флаг "Формировать скриншот при ошибке"
		И     в поле каталог скриншотов я указываю путь к относительному каталогу "tools\ScreenShotsTest"
		И я перехожу к закладке с именем "СтраницаСервисОсновные"
		И     В открытой форме в поле "Команда создания скриншотов" я ввожу команду для IrfanView 
		И я перехожу к закладке "Автоинструкции"
		Затем В поле с именем "КаталогФичСлужебный" я указываю путь к служебной фиче "ДляПроверкиСнятияСкриншотаШага"
		И Я нажимаю на кнопку перезагрузить сценарии в Vanessa-Automation TestClient
		И     Я нажимаю на кнопку выполнить сценарии в Vanessa-Automation TestClient
		И в каталоге скриншотов появился хотя бы один скриншот
