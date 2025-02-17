Синхронный полет (тестовое задание)
================

### Описание дисциплины

В рамках дисциплины «Синхронный полет» задача Команды разработать и запрограммировать алгоритм, позволяющий группе беспилотных аппаратов преодолеть гоночную трассу, выстраиваясь перед трибунами зрителей в геометрические формации различной сложности.

### Группа беспилотных аппаратов

В тестовом задании группа беспилотных аппаратов состоит из одинаковых аппаратов в количестве 6 штук.

Аппараты являются цифровыми двойниками реальных моделей беспилотных летательных аппаратов двух типов:

* мультироторный (квадрокоптер);
* самолетный (планер вертикального взлета и посадки).

### Гоночная трасса

Гоночная трасса представляет собой спортивный стадион.

![Formation_1](https://github.com/acsl-mipt/drone-games/blob/main/.imgs/1.png)

Полет группы аппаратов осуществляется над беговыми дорожками по направлению против часовой стрелки. Место старта находится за правыми футбольными воротами.

![Formation_2](https://github.com/acsl-mipt/drone-games/blob/main/.imgs/2.png)

Зоны пролета - части беговых дорожек, отмеченные зеленым цветом.

Над зонами пролета группа аппаратов должна двигаться поддерживая формацию (взаимное пространственное расположение) в соответствии с полученным заданием.

Размеры зон пролета: длина 124 метров, ширина 20 метров, высота 50 метров.

Зоны перестроения - части беговых дорожек, отмеченные желтым цветом.

Пролетая над зонами перестроения группа аппаратов должна перестроится в новую формацию в соответствии с полученным заданием.

Размеры зон перестроения: длина 102 метра, ширина 20 метров, высота 50 метров.

Центры зон пролета расположены по следующим координатам: (41; 0) и (-41; 0), зон перестроения: (0; 72) и (0; -72).

![Formation_3](https://github.com/acsl-mipt/drone-games/blob/main/.imgs/3.png)

Над стадионом введено ограничительное пространство со следующими размерами: длина 214 метров, ширина 148 метров, высота 100 метров, не позволяющее вылететь за пределы (-74; 74) по X, (-107; 107) по Y, (0; 100) по Z.

Ограничительное пространство введено для того чтобы аппараты при нештатных ситуациях не разлетались на большие расстояния. Для аппаратов ограничительное пространство является непроходимой стеной и на нем работает механизм упругого столкновения.

### Системы координат

В Симуляторе используются следующие системы координат:

* локальная система координат автопилота (точка отсчета соответствует месту включения аппарата, опция --ref_point в скрипте запуска
* локальная система координат Симулятора (точка отсчета в центре стадиона на уровне земли)

и следующие базисы:

* ENU (Восток-Север-Вверх) для локальной системы координат Симулятора, сообщений ROS/Mavros
* NED (Север-Восток-Вниз) для автопилота PX4 и сообщений Mavlink

Все координаты объектов в текущем документе заданы в локальной системе координат Симулятора.
Обратите внимание, что точкой (0,0) в локальной системе координат автопилота аппарат считает ту точку, которую вы передали в опции --ref_point в локальной системе координат Симулятора.
Так же следует отметить: несмотря на то, что автопилот работает в базисе NED, при обмене с ним с помощью Mavros, базисы систем координат автопилота и Симулятора становятся одинаковыми (ENU). То есть, если вы не использовали опцию --ref_point, локальные системы координат автопилота и Симулятора фактически совпадают.

### Алгоритм управления

Управление каждым аппаратом в группе происходит с помощью централизованного алгоритма, разрабатываемого Командой.

Управляющие воздействия на аппараты выдаются в одном из следующих вариантов:

* по точкам в локальной системе координат (ENU) для мультироторов и самолетов;
* по скоростям в локальной системе координат (ENU) для мультироторов;
* по скоростям в плоскости и заданию высоты в локальной системе координат (ENU) для самолетов.

Алгоритмы должны быть или уникальными или иметь принципиальные отличия от общедоступных. Работоспособность алгоритмов будет оцениваться автоматизировано, при помощи системы автоматического судейства встроенной в Симулятор.

С примером реализации алгоритма управления вы можете ознакомиться в файле `examples/group.py`.

### Формации

Формации представляют собой совокупность точек пространства, в каждой из которых должен находиться один аппарат из группы. При этом любой аппарат группы может занимать любую точку.

Формации задаются в относительных координатах (базис системы координат - "Вправо-Вперед-Вверх", где Вперед - по ходу движения, а точка отсчета произвольна), например, построение в виде буквы «Т» из шести аппаратов будет задано в таком виде: (0, -3, 11), (0, -1, 11), (0, 1, 11), (0, 3, 11), (0, 0, 8), (0, 0, 5).

### Запуск

Для запуска Симулятора в режиме Любительской лиги выполните команду

```
./formation.sh nonprof
```

Для запуска Симулятора в режиме Профессиональной лиги выполните команду

```
./formation.sh prof
```

После успешного выполнения скрипта вы должны увидеть следующее:

![Formation](https://github.com/acsl-mipt/drone-games/blob/main/.imgs/formation.png)

### Задание

Задача Команды разработать алгоритм управления группой аппаратов, который автоматически:

* распределит месторасположение аппаратов в каждой из формаций;
* выдаст управляющие воздействия на аппараты для поддержания формаций;
* выдаст управляющие воздействия на аппараты для перестроения между формациями;
* выдаст управляющие воздействия на аппараты для перемещения по гоночной трассе для выполнения полного полетного задания.

![Formation_4](https://github.com/acsl-mipt/drone-games/blob/main/.imgs/4.png)

#### Для Любительской лиги:

Полное полетное задание в виде последовательности и набора необходимых для выполнения формаций известно заранее и находится в папке `formation`: 

* в файле `borders.txt` хранятся координаты границ зон в виде двух точек, являющихся концами отрезка,
* в папке `test_fs` хранятся текстовые файлы с относительными координатами формаций. 

В каждой зоне пролета (до выхода из нее) должна поддерживаться одна формация согласно полученному полетному заданию. После чего в зоне перестроения должно быть выполнено перестроение в следующую по полетному заданию формацию и ее поддержание в ближайшей зоне пролета по направлению движения (показано стрелками). Для тестового задания формаций четыре:

* первая формация - буква Т: (0, -3, 11), (0, -1, 11), (0, 1, 11), (0, 3, 11), (0, 0, 8), (0, 0, 5)
* вторая - Е: (0, 0, 11), (0, 3, 11), (0, 0, 8), (0, 3, 8), (0, 0, 5), (0, 3, 5)
* третья - С: (0, 1, 9), (0, 0, 11), (0, -2, 9), (0, -2, 7), (0, 0, 5), (0, 1, 6)
* четвертая - снова "Т"

#### Для Профессиональной лиги:

При запуске Симулятора автоматически выдается полетное задание в виде необходимой для выполнения формаций в ближайшей зоне пролета по направлению движения (показано стрелками). В тот момент, когда один из аппаратов переходит из зоны пролета в зону перестроения (красные линии), публикуется следующая необходимая для выполнения формаций в ближайшей зоне пролета по направлению движения.

При запуске скрипта `./formation.sh prof` также запускается ROS-нода, публикующая в ROS-топик `/formations_generator/formation` текущие относительные координаты для построения формации в формате `std_msgs.msg.String`: 

```
НАЗВАНИЕ_ФОРМАЦИИ КООРДИНАТА_X_1 КООРДИНАТА_Y_1 КООРДИНАТА_Z_1 КООРДИНАТА_X_2 КООРДИНАТА_Y_2 КООРДИНАТА_Z_2 ...
```

Координаты текущей требуемой формации публикуются в вышеназванный ROS-топик. В тот момент, когда один из аппаратов переходит из зоны пролета в зону перестроения, начинают публиковаться новые относительные координаты.

### Определение отобранных команд

Команды, которые успешно смогут выполнить тестовое задние до 12 апреля (включительно) проходят в финальную часть соревнований.
