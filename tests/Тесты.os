#Использовать asserts
#Использовать ".."

Функция ПолучитьСписокТестов(ЮнитТестирование) Экспорт
	ВсеТесты = Новый Массив;
	ВсеТесты.Добавить("ТестДолжен_ПроверитьЧтоПравильноОпределяетсяПингКонфигуратора");
	ВсеТесты.Добавить("ТестДолжен_ПроверитьЧтоПравильноОпределяетсяКонецСообщения");
	ВсеТесты.Добавить("ТестДолжен_ПроверитьЧтоРаботаетРазборЗапросаКонфигуратораНаПомещениеВХранилище");
	//ВсеТесты.Добавить("ТестовыйТест");

	Возврат ВсеТесты;
КонецФункции

Процедура ТестовыйТест() Экспорт
	//Результат = ПростоМодуль.ПроверкаСвязи();
	//Ожидаем.Что(Результат).Равно(1);
КонецПроцедуры

Процедура ПередЗапускомТестов()
КонецПроцедуры

Процедура ПослеЗапускаТестов()
КонецПроцедуры

Процедура ТестДолжен_ПроверитьЧтоПравильноОпределяетсяПингКонфигуратора() Экспорт
	Обработчик = ОбработкаДанных;

	ДД_Пинг = ПолучитьДвоичныеДанныеИзHexСтроки("214754B3");
	ЭтоПинг = Обработчик.ЭтоПинг(ДД_Пинг);
	Ожидаем.Что(ЭтоПинг, "проверка сигнатуры пинга").Равно(Истина);

	ДД_Пинг = ПолучитьДвоичныеДанныеИзHexСтроки("214754B3214754B3214754B3214754B3214754B3");
	ЭтоПинг = Обработчик.ЭтоПинг(ДД_Пинг);
	Ожидаем.Что(ЭтоПинг, "проверка сигнатуры пинга несколько раз подряд").Равно(Истина);

	ДД_Пинг = ПолучитьДвоичныеДанныеИзHexСтроки("");
	ЭтоПинг = Обработчик.ЭтоПинг(ДД_Пинг);
	Ожидаем.Что(ЭтоПинг, "проверка с пустыми двоичными данными").Равно(Истина);

	ДД_Пинг = ПолучитьДвоичныеДанныеИзHexСтроки("A3B4C5D6");
	ЭтоПинг = Обработчик.ЭтоПинг(ДД_Пинг);
	Ожидаем.Что(ЭтоПинг, "проверка функции пинга случайными дд 1").Равно(Ложь);

	ДД_Пинг = ПолучитьДвоичныеДанныеИзHexСтроки("A3B4C5D6F7");
	ЭтоПинг = Обработчик.ЭтоПинг(ДД_Пинг);
	Ожидаем.Что(ЭтоПинг, "проверка функции пинга случайными дд 2").Равно(Ложь);
КонецПроцедуры

Процедура ТестДолжен_ПроверитьЧтоПравильноОпределяетсяКонецСообщения() Экспорт
	Обработчик = ОбработкаДанных;

	ДД = ПолучитьДвоичныеДанныеИзHexСтроки("6653B2A6");
	ЕстьКонецСообщения = Обработчик.ЕстьКонецСообщения(ДД);
	Ожидаем.Что(ЕстьКонецСообщения, "сигнатура конца сообщения").Равно(Истина);

	ДД = ПолучитьДвоичныеДанныеИзHexСтроки("6653B2A66653B2A66653B2A66653B2A66653B2A6");
	ЕстьКонецСообщения = Обработчик.ЕстьКонецСообщения(ДД);
	Ожидаем.Что(ЕстьКонецСообщения, "сигнатура конца сообщения несколько раз").Равно(Истина);

	ДД = ПолучитьДвоичныеДанныеИзHexСтроки("");
	ЕстьКонецСообщения = Обработчик.ЕстьКонецСообщения(ДД);
	Ожидаем.Что(ЕстьКонецСообщения, "пустые ДД").Равно(Ложь);

	ДД = ПолучитьДвоичныеДанныеИзHexСтроки("A3B4C5D6F7");
	ЕстьКонецСообщения = Обработчик.ЕстьКонецСообщения(ДД);
	Ожидаем.Что(ЕстьКонецСообщения, "случайные ДД 4 байта").Равно(Ложь);

	ДД = ПолучитьДвоичныеДанныеИзHexСтроки("6653B2A6A3B4C5D6F7");
	ЕстьКонецСообщения = Обработчик.ЕстьКонецСообщения(ДД);
	Ожидаем.Что(ЕстьКонецСообщения, "первая часть - сигнатура конца, вторая - случайные").Равно(Ложь);

	ДД = ПолучитьДвоичныеДанныеИзHexСтроки("A3B4C5D6F76653B2A6A3B4C5D6F7");
	ЕстьКонецСообщения = Обработчик.ЕстьКонецСообщения(ДД);
	Ожидаем.Что(ЕстьКонецСообщения, "сигнатура конца в середине между случайными").Равно(Ложь);
КонецПроцедуры

Функция ПолучитьДвоичныеДанныеЗапросаКонфигуратораНаПомещениеДанныхВХранилище()
	Возврат Новый ДвоичныеДанные(".\tests\ДвоичныеДанныеЗапросаКонфигуратораНаПомещениеДанныхВХранилище.dat");
КонецФункции

Процедура ТестДолжен_ПроверитьЧтоРаботаетРазборЗапросаКонфигуратораНаПомещениеВХранилище() Экспорт
	Обработчик = ОбработкаДанных;
	ДД = ПолучитьДвоичныеДанныеЗапросаКонфигуратораНаПомещениеДанныхВХранилище();
	ПараметрыЗапроса = Обработчик.ПолучитьПараметрыЗапроса(ДД);
	Ожидаем.Что(ПараметрыЗапроса.Проверять, "проверка признака Проверять из файла").Равно(Истина);
	Ожидаем.Что(ПараметрыЗапроса.ИмяСистемы, "проверка признака ИмяСистемы из файла").Равно("p_buying_test");
	Ожидаем.Что(ПараметрыЗапроса.ИмяМетода, "проверка признака ИмяМетода из файла").Равно("DevDepot_commitObjects");
	Ожидаем.Что(ПараметрыЗапроса.ВерсияПлатформы, "проверка признака ВерсияПлатформы из файла").Равно("8.3.22.2143");
	Ожидаем.Что(ПараметрыЗапроса.Комментарий, "проверка признака Комментарий из файла").Равно("тестовый комментарий");
	Ожидаем.Что(ПараметрыЗапроса.ИмяПользователя, "проверка признака ИмяПользователя из файла").Равно("Administrator");

	ПараметрыЗапроса = Обработчик.ПолучитьПараметрыЗапроса(ПолучитьДвоичныеДанныеИзHexСтроки(""));
	Ожидаем.Что(ПараметрыЗапроса, "на пустых ДД выдаст неопределено").Равно(Неопределено);

	ПараметрыЗапроса = Обработчик.ПолучитьПараметрыЗапроса(ПолучитьДвоичныеДанныеИзHexСтроки("A3B4C5F6"));
	Ожидаем.Что(ПараметрыЗапроса, "на случайных ДД выдаст неопределено").Равно(Неопределено);
КонецПроцедуры