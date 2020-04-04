# Задание
На старте приложения случайным образом (в случайные начальные позиции) в аквариум должны быть добавлены 10 рыб. Рыбы бывают двух видов: хищные и "травоядные". Рыбы могут иметь размер от 1 до 3 условных единиц. Скорость рыбы обратна размеру, то есть рыба размером 1 плавает со скоростью 3 и т.д. Каждая рыба при появлении в аквариуме начинает плыть в случайном направлении с положенной ей скоростью и как только достигает края аквариума (аквариум это собственно экран) меняет движение на другое случайное направление, оставаясь внутри аквариума. Хищные рыбы едят других хищных рыб и травоядных. Рыба меньшего размера не может съесть рыбу большего размера (Исключение: Хищная рыба размера n может поедать травоядных рыб размером <= n+1). Если рыбу съели она должна исчезнуть с экрана и через 15 секунд надо запустить новую случайную рыбу случайного размера в аквариум. Столкновения можно, для простоты, определять пересечением прямоугольников - реальная форма рыбы на картинке не имеет значения.

# Реализация
Приложение реализовано с помощью разбиения на слои `data`, `domain` и `view`. Анимация движения рыб и проверка столкновений реализованы в отдельном единственном потоке. Чтобы посмотреть на реализацию движения рыб с помощью пакета `flutter/animation.dart` необходимо переключиться на ветку `master`.