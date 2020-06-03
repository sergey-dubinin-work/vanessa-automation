﻿#Область ОписаниеПеременных

&НаКлиенте
Перем Ванесса Экспорт;

#КонецОбласти

#Область ЭкспортныеПроцедурыИФункции

&НаКлиенте
Функция ДанныеШаговДляРедактора(СтруктураПараметров) Экспорт
	
	ТаблицаИзвестныхStepDefinition = СтруктураПараметров.ТаблицаИзвестныхStepDefinition;
	ТаблицаУжеСуществующихСценариев = СтруктураПараметров.ТаблицаУжеСуществующихСценариев;
	МодульПарсерФич = СтруктураПараметров.МодульПарсерФич;
	Язык = СтруктураПараметров.Язык;
	Ванесса = СтруктураПараметров.Ванесса;
	
	ДанныеДляПеревода = Неопределено;
	ДанныеКатегорийШагов = Неопределено;
	ДанныеПереводаШагов = Неопределено;
	Если Язык <> "ru" Тогда
		ДанныеДляПеревода = ПолучитьДанныеДляПеревода(СтруктураПараметров.КешДанныеПеревода);
		ДанныеКатегорийШагов = ДанныеДляПеревода.ДанныеКатегорийШагов;
		ДанныеПереводаШагов = ДанныеДляПеревода.ДанныеПереводаШагов;
	КонецЕсли;	 
	
	ДанныеФичи = Новый Структура;
	ДанныеФичи.Вставить("ЯзыкФичи", Язык);
		
	ЗаписьJSON = Новый ЗаписьJSON;
	ЗаписьJSON.УстановитьСтроку();
	ЗаписьJSON.ЗаписатьНачалоМассива();
	Для Каждого СтрокаТаблицаИзвестныхStepDefinition Из ТаблицаИзвестныхStepDefinition Цикл
		Если ПустаяСтрока(СтрокаТаблицаИзвестныхStepDefinition.ТипШага) Тогда
			Продолжить;
		КонецЕсли;	 
		Если ПустаяСтрока(СтрокаТаблицаИзвестныхStepDefinition.ОписаниеШага) Тогда
			Продолжить;
		КонецЕсли;	 
		
		ВтораяЧастьСтрокиПозиция = -1;
		
		ПримерИспользования = СтрокаТаблицаИзвестныхStepDefinition.ПредставлениеТеста;
		ОписаниеШага = СтрокаТаблицаИзвестныхStepDefinition.ОписаниеШага;
		ТипШага = СтрокаТаблицаИзвестныхStepDefinition.ТипШага;
		Если Язык <> "ru" Тогда
			ДанныеПереводаШага = ДанныеПереводаШагов[СтрокаТаблицаИзвестныхStepDefinition.СтрокаДляПоиска];
			Если ДанныеПереводаШага <> Неопределено Тогда
				ПримерИспользования = УбратьЛишниеСимволыИзПредставленияШага(ДанныеПереводаШага.ТекстПереводаШаг);
				ОписаниеШага = ДанныеПереводаШага.ТекстПереводаОписание;
				ТипШага = ПеревестиТипШага(ДанныеКатегорийШагов, ТипШага);
			Иначе
				Продолжить;
			КонецЕсли;	 
		КонецЕсли;	 
		
		МодульПарсерФич.ПолучитьКлючевоеСлово(ДанныеФичи,
			ПримерИспользования, ВтораяЧастьСтрокиПозиция);
		ИмяШагаБезКлючевогоСлова = СокрЛП(Сред(ПримерИспользования, ВтораяЧастьСтрокиПозиция));
		
		ЗаписьJSON.ЗаписатьНачалоОбъекта();
		ЗаписьJSON.ЗаписатьИмяСвойства("filterText");
		ЗаписьJSON.ЗаписатьЗначение(ИмяШагаБезКлючевогоСлова);
		ЗаписьJSON.ЗаписатьИмяСвойства("insertText");
		ЗаписьJSON.ЗаписатьЗначение(ПримерИспользования);
		ЗаписьJSON.ЗаписатьИмяСвойства("sortText");
		ЗаписьJSON.ЗаписатьЗначение("");
		ЗаписьJSON.ЗаписатьИмяСвойства("documentation");
		ЗаписьJSON.ЗаписатьЗначение(ОписаниеШага);
		ЗаписьJSON.ЗаписатьИмяСвойства("kind");
		ЗаписьJSON.ЗаписатьЗначение(ТипШага(СтрокаТаблицаИзвестныхStepDefinition));
		ЗаписьJSON.ЗаписатьИмяСвойства("section");
		ЗаписьJSON.ЗаписатьЗначение(ТипШага);
		ЗаписьJSON.ЗаписатьКонецОбъекта();
	КонецЦикла;	 
	
	
	Для Каждого СтрокаТаблицаУжеСуществующихСценариев Из ТаблицаУжеСуществующихСценариев Цикл
		Если ПустаяСтрока(СтрокаТаблицаУжеСуществующихСценариев.ТипШага) Тогда
			Продолжить;
		КонецЕсли;	 
		Если ПустаяСтрока(СтрокаТаблицаУжеСуществующихСценариев.ОписаниеШага) Тогда
			Продолжить;
		КонецЕсли;	 
		
		ПримерИспользования = СтрокаТаблицаУжеСуществующихСценариев.ПримерИспользования;
		ОписаниеШага = СтрокаТаблицаУжеСуществующихСценариев.ОписаниеШага;
		ТипШага = СтрокаТаблицаУжеСуществующихСценариев.ТипШага;
		Если Язык <> "ru" Тогда
			ДанныеПереводаШага = ДанныеПереводаШагов[СтрокаТаблицаУжеСуществующихСценариев.Снипет];
			Если ДанныеПереводаШага <> Неопределено Тогда
				ПримерИспользования = УбратьЛишниеСимволыИзПредставленияШага(ДанныеПереводаШага.ТекстПереводаШаг);
				ОписаниеШага = ДанныеПереводаШага.ТекстПереводаОписание;
				ТипШага = ПеревестиТипШага(ДанныеКатегорийШагов, ТипШага);
			Иначе
				Продолжить;
			КонецЕсли;	 
		КонецЕсли;	 
		
		МодульПарсерФич.ПолучитьКлючевоеСлово(ДанныеФичи, ПримерИспользования, ВтораяЧастьСтрокиПозиция);
		ИмяШагаБезКлючевогоСлова = СокрЛП(Сред(ПримерИспользования, ВтораяЧастьСтрокиПозиция));
		
		ЗаписьJSON.ЗаписатьНачалоОбъекта();
		ЗаписьJSON.ЗаписатьИмяСвойства("filterText");
		ЗаписьJSON.ЗаписатьЗначение(ИмяШагаБезКлючевогоСлова);
		ЗаписьJSON.ЗаписатьИмяСвойства("insertText");
		ЗаписьJSON.ЗаписатьЗначение(ПримерИспользования);
		ЗаписьJSON.ЗаписатьИмяСвойства("sortText");
		ЗаписьJSON.ЗаписатьЗначение("");
		ЗаписьJSON.ЗаписатьИмяСвойства("documentation");
		ЗаписьJSON.ЗаписатьЗначение(ОписаниеШага);
		ЗаписьJSON.ЗаписатьИмяСвойства("kind");
		ЗаписьJSON.ЗаписатьЗначение(17);
		ЗаписьJSON.ЗаписатьИмяСвойства("section");
		ЗаписьJSON.ЗаписатьЗначение(ТипШага);
		ЗаписьJSON.ЗаписатьКонецОбъекта();
	КонецЦикла;	 
	
	ЗаписьJSON.ЗаписатьКонецМассива();
	
	Данные = ЗаписьJSON.Закрыть();
	
	Возврат Данные;
КонецФункции	 

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Функция ТипШага(ДанныеШага)
	Результат = 0;
	
	Если ДанныеШага.ТипШагаВДереве = "Условие" Тогда
		Результат = 5;
	ИначеЕсли ДанныеШага.ТипШагаВДереве = "Цикл" Тогда
		Результат = 8;
	ИначеЕсли Найти(ДанныеШага.ПредставлениеТеста, "в течение") Тогда
		Результат = 7;
	ИначеЕсли Найти(ДанныеШага.ПредставлениеТеста, "файл") > 0 Тогда
		Результат = 23;
	ИначеЕсли Найти(ДанныеШага.ТипШага, "Прочее.") > 0 Тогда
		Результат = 4;
	КонецЕсли;	 
	
	Возврат Результат;
КонецФункции	 

&НаСервереБезКонтекста
Функция ПолучитьДанныеДляПеревода(КешДанныеПеревода)
	ДанныеПеревода = Новый Структура;
	ДанныеПереводаШагов = Новый Соответствие;
	ДанныеКатегорийШагов = Новый Соответствие;
	Если ЗначениеЗаполнено(КешДанныеПеревода) Тогда
		ТаблицаПеревода = ПолучитьИзВременногоХранилища(КешДанныеПеревода.ТаблицаПеревода);
		Для Каждого СтрокаТаблицаПеревода Из ТаблицаПеревода Цикл
			//Если ПустаяСтрока(СтрокаТаблицаПеревода.КлючевоеСлово) Тогда
			//	Продолжить;
			//КонецЕсли;	 
			
			Если СтрокаТаблицаПеревода.ОригиналРусскийОписание = "Категория шагов" Тогда
				ДанныеКатегорийШагов.Вставить(СтрокаТаблицаПеревода.ОригиналРусскийШаг, СтрокаТаблицаПеревода.ТекстПереводаШаг);
				Продолжить;
			КонецЕсли;	 
			
			ДанныеШага = Новый Структура;
			ДанныеШага.Вставить("ТекстПереводаШаг", СтрокаТаблицаПеревода.ТекстПереводаШаг);
			ДанныеШага.Вставить("ТекстПереводаОписание", СтрокаТаблицаПеревода.ТекстПереводаОписание);
			
			ДанныеПереводаШагов.Вставить(СтрокаТаблицаПеревода.СтрокаДляПоискаРусский, ДанныеШага);
		КонецЦикла;	 
	КонецЕсли;	 
	
	ДанныеПеревода.Вставить("ДанныеПереводаШагов", ДанныеПереводаШагов);
	ДанныеПеревода.Вставить("ДанныеКатегорийШагов", ДанныеКатегорийШагов);
	
	Возврат ДанныеПеревода;
КонецФункции	

&НаКлиенте
Функция УбратьЛишниеСимволыИзПредставленияШага(Знач Стр)
	Стр = СтрЗаменить(Стр,"%1 ","");
	Стр = СтрЗаменить(Стр,"%2 ","");
	Стр = СтрЗаменить(Стр,"%3 ","");
	Стр = СтрЗаменить(Стр,"%4 ","");
	Стр = СтрЗаменить(Стр,"%5 ","");
	Стр = СтрЗаменить(Стр,"%6 ","");
	Возврат Стр;
КонецФункции	 

&НаКлиенте
Функция ПеревестиТипШага(ДанныеКатегорийШагов, Знач ТипШага)
	МассивСтрок = Ванесса.РазложитьСтрокуВМассивПодстрокКлиент(ТипШага, ".");
	Для Сч = 0 По МассивСтрок.Количество()-1 Цикл
		ЗначениеПеревода = ДанныеКатегорийШагов[МассивСтрок[Сч]];
		Если ЗначениеПеревода = Неопределено Тогда
			МассивСтрок[Сч] = "";
			Продолжить;
		КонецЕсли;	 
		
		МассивСтрок[Сч] = ЗначениеПеревода;
	КонецЦикла;	
	
	Результат = Ванесса.МассивВСтроку(МассивСтрок, ".");
	Если Прав(Результат, 1) = "." Тогда
		Результат = Лев(Результат, СтрДлина(Результат) - 1)
	КонецЕсли;	 
	Возврат Результат;
	
КонецФункции	 

#КонецОбласти