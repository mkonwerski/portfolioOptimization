# Portfolio Optimization - optymalizacja portfela inwestycyjnego
Postanowiłem świadomie inwestować w TFI poprzez optymalizacja portfela inwestycyjnego.  Natrafiłem na fenomenalną [stronę](https://zerodha.com/varsity/chapter/orientation-note/), która tłumaczy i pokazuje, jak ograć to zagadniecie w Exelu. Natrafiłem na fenomenalną stronę, która tłumaczy i pokazuje, jak ograć to zagadnienie w Exelu. Szybko okazało się, że należy zautomatyzować pewne procesy, aby przyśpieszyć liczenie optymalnego portfela. W tym pomógł mi język R CRAN. Kilka minut szperania w internecie i udało mi się osiągnąć zamierzony cel, mam świadomość, że jest to nie optymalne, nie zgrabne rozwiązanie, ale do moich celów wystarczające.

Repo zawiera:
- kurs ze strony [zerodha.com](https://zerodha.com/varsity/chapter/orientation-note/)
- skrypt pobierający notowanie TFI NN Investment Partners oraz obliczanie dziennego zwrotu
- skrypt obliczający optymalny portfel inwestycyjny
	- rysuje granice portfela
	- oblicza portfel z minimalnym ryzykimem
    - oblicza portfel na podstawie wskaźnik Sharpe'a.
