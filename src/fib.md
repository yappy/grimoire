# フィボナッチ数列

\\[
\begin{eqnarray}
  F_{n+2} &=& F_{n+1} + F_{n} \\\\
  F_1 &=& 1 \\\\
  F_2 &=& 1 \\\\
\end{eqnarray}
\\]

## 例

\\[
\begin{eqnarray}
  F_0 &=& 0 \\\\
  F_1 &=& 1 \\\\
  F_2 &=& 1 \\\\
  F_3 &=& 2 \\\\
  F_4 &=& 3 \\\\
  F_5 &=& 5 \\\\
  F_6 &=& 8 \\\\
  F_7 &=& 13 \\\\
  F_8 &=& 21 \\\\
  F_9 &=& 34 \\\\
  F_{10} &=& 55 \\\\
\end{eqnarray}
\\]

小学校の足し算ができれば遊べるフレンドリーな問題です。

### 補足

ちょっと考えると、別に n を増やす方向にしか使えないわけではなく、
連続する3項のうち2項が分かっていて「抜け」が1つだけなら他の2項から求めることができる。
したがって、マイナスの方向にも進んでいくこともできる。
これにより \\( F_0 = 0 \\) とできるし、0番目から始めてもよい。

## 隣接三項間漸化式

\\[ 1 \cdot F_{n+2} = 1 \cdot F_{n+1} + 1 \cdot F_{n} \\]

この漸化式はよく見ると全係数が1の線形和の形になっており、
高校数学に出てくる隣接三項間漸化式である。
なので例の謎解法を用いて解く (一般解を得る) ことができる。

漸化式から謎ルールにより特性方程式は

\\[
\begin{eqnarray}
  F_{n+2} &=& F_{n+1} + F_{n} \\\\
  x^2 &=& x + 1 \\\\
  x^2 &-& x - 1 = 0
\end{eqnarray} \\]

で、これは幸いにも実数解が2つ得られて、

\\[ x = \frac{ 1 \pm \sqrt{5} }{2} \\]

通常高校生に解かせる問題はここがきれいな整数になるよう調整されているが、
係数が全部1できれいだと思わせておいて、このような無理数になってしまう。
何度も書くのはツラいので、文字で置き換えることとする。
( \\( \alpha \\) は **黄金比** と呼ばれる数で、人が「きれいに」感じる比率である。
自然界にも多く存在する。)

\\[
\begin{eqnarray}
  \alpha &=& \dfrac{ 1 + \sqrt{5} }{2} \\\\
  \beta  &=& \dfrac{ 1 - \sqrt{5} }{2}
\end{eqnarray}
\\]

この特性方程式の解を使うと謎解法により、漸化式は以下の2通りに変形できる。

\\[
\begin{eqnarray}
  F_{n+2} - \alpha F_{n+1} &=& \beta  ( F_{n+1} - \alpha F_{n} ) \\\\
  F_{n+2} - \beta  F_{n+1} &=& \alpha ( F_{n+1} - \beta  F_{n} )
\end{eqnarray}
\\]

どこからこんな変形が出てくるのか本当に意味が分からないと思われる (意味は後述) が、
展開して検算してみると確かにどちらも元の式に戻る。
これらの式は以下のような新しい数列を考えると、単純な等比数列になることを示している。
公比は順に \\( \beta, \alpha \\) である。

\\[
\begin{eqnarray}
  a_n = F_{n+1} - \alpha F_n \\\\
  b_n = F_{n+1} - \beta  F_n
\end{eqnarray}
\\]

等比数列は簡単に一般項を表現できて、n 番目の値は 1 番目の値に公比を n - 1 回
かけたものだから、以下の一般項を得る。

\\[
\begin{eqnarray}
  a_n &=& a_1 \cdot \beta ^{n-1} \\\\
  b_n &=& b_1 \cdot \alpha^{n-1} \\\\
  a_1 &=& F_2 - \alpha F_1 = 1 - \alpha \\\\
      &=& \beta \\\\
  b_1 &=& F_2 - \beta  F_1 = 1 - \beta \\\\
      &=& \alpha
\end{eqnarray}
\\]

\\( \alpha + \beta \\) を計算してみると1になることから、初項は1文字できれいに
表すことができる。
それ以外に関しては高校数学のテンプレ解法をなぞっただけである。
まとめるとやたらきれいになる (うまく文字で置き換えたからでもあるが)。

\\[
\begin{eqnarray}
  a_n &=& \beta  ^ n \\\\
  b_n &=& \alpha ^ n
\end{eqnarray}
\\]

新しく作った数列をもとのフィボナッチ数列に戻してやると

\\[
\begin{eqnarray}
  F_{n+1} - \alpha F_n &=& \beta  ^ n \\\\
  F_{n+1} - \beta  F_n &=& \alpha ^ n
\end{eqnarray}
\\]

辺々引き算すると \\( F_{n+1} \\) を消去できる。

\\[ ( \alpha - \beta ) F_n = \alpha ^ n - \beta ^ n　\\]

これはもう解けていて、フィボナッチ数列の一般項を求められている。
\\( \alpha, \beta\\) を代入すると

\\[
\begin{eqnarray}
  \alpha &=& \frac{ 1 + \sqrt 5 }{2} , \quad
  \beta  = \frac{ 1 - \sqrt 5 }{2} \\\\
  F_n &=& \frac{ 1 }{ \alpha - \beta } ( \alpha ^ n - \beta ^ n ) \\\\
  F_n &=& \frac{ 1 }{ \sqrt 5 } \left \\{
    \left ( \frac{ 1 + \sqrt{5} }{2} \right ) ^ n -
    \left ( \frac{ 1 - \sqrt{5} }{2} \right ) ^ n
  \right \\}
\end{eqnarray}
\\]

とても整数になるようには見えないが、フィボナッチ数列の定義より明らかに
全ての整数 \\( n \\) について \\( F_n \\) は整数である。
実際、\\( n \\) に具体的な整数を代入してみると魔法のように整数になる。

## なんやねんこれは

フィボナッチ数列の問題というよりは、隣接三項間漸化式の解き方だけを高校生に教えており
なぜこれで解けるのか意味が分からないところが問題である。

実は線形和になっている隣接三項間漸化式は **二階の線形微分方程式(同次形)** と
解き方がそっくりである。そっくりどころか、数学的にしっかり解析すると
**同型** であるとまで言えてしまう。

漸化式の \\( a_{n+1} - a_n \\) のことを **差分** とも呼び、
これに関する方程式を **差分方程式** とも呼ぶ。
\\(y\\) を \\(x\\) の関数とするとき、\\( y' = \frac{ dy }{ dx } \\) を
**微分** と呼び、これに関する方程式を **微分方程式** と呼ぶ。
差分方程式は、連続的な関数に関する微分方程式を、離散的な関数 (数列) で考える
バージョンだととらえることができる。

フィボナッチ数列に *そっくりな* 微分方程式は以下のようになる。

\\[
\begin{eqnarray}
y'' = y' + y \\\\
y'' - y' - y = 0
\end{eqnarray}
\\]

このような形の方程式は解き方が確立されている。
高校では取り扱わないのだが、同型だと言った通り、隣接三項間漸化式の解き方という扱いで
日本の高校生は実質的に解かされている…。

しかしながら高校物理における単振動は運動方程式がこの形の微分方程式であり、
(実数)解が三角関数になるという結果を暗記させられる。
これもどうかという気はするが、微分方程式は解くのは (非常に) 難しいが
解の候補が正しいかは実際に微分して代入して成り立つか調べるだけで確認できるため、
ギリギリ許せるかもしれない。
しかし \\( t \\) の係数である角周波数 \\( \omega \\) が質量とばね定数から
決定できて振動の周期や (周波数) を確定できるというのは、
さすがに微積分なしという建前の上でかなりの無茶をやっている気がする。。

\\[
\begin{eqnarray}
m \frac{ d^2 x }{ d t^2 } = - k x \\\\
m x'' + kx = 0 \\\\
x'' + \frac{k}{m} x = 0 \\\\
x'' + \omega ^2 x = 0 \\\\
\cdots \\\\
x(t) = A \sin ( \omega t + \phi )\\\\
\omega = \sqrt{\frac{k}{m}}
\end{eqnarray}
\\]

とにかく、階数 (微分回数) に関わらず線形微分方程式の解き方は確立されていて、
それは以下の考察による。

\\( f(x), g(x) \\) が解のとき、

* 定数倍 \\( c f(x) \\) も解である。
* \\( f(x) + g(x) \\) も解である。

これは以下の微分の性質を線形微分方程式に代入すれば確認できる。

* \\( \\{ c f (x) \\}' = c f'(x) \\)
* \\( \\{ f(x) + g(x) \\}' = f'(x) + g'(x) \\)

これを踏まえた解法は以下のようになる。

1. なんでもいいから頑張って特殊解 (特解) を2つ (二階の場合) 探す。
  ただし定数倍の関係になっているものは除く(**一次独立**という)。
1. その2つを \\( f(x), g(x) \\) とすると、
  \\( C f(x) \\) や \\( D g(x) \\) も解だし、
  解の和もまた解である。
1. \\( y = C f(x) + D g(x) \\) が解全体 (一般解) となる (C, D は任意定数)。
1. **初期条件** を1つ与えられると、任意定数を1つ決定することができる。
  二階の場合は2つ出てくるので、任意性を消すためには初期条件が2つ必要である。
  これはフィボナッチ数列で言えば最初の2項が必要であることに相当する。

これの他に解が無いことはどう証明するのか？などと考えてしまいそうになるが、
とんでもなく難しい話になるので気にしてはいけない (数学科へ GO)。
2回の微分を行っているので、任意定数 (積分定数みたいなもの) が2つ出てくれば
全部の解を覆いつくせていると考えておけば OK ではないが OK。

問題は一般解でなくていいとはいえ特殊解をどうやって探すかだが、

\\[
y'' - y' - y = 0
\\]

この式をよく見ると y を微分したりもう一回微分したりしても、元の y の定数倍にしか
ならないようなものしか解にならなそうに見える。
微分 **方程式** と名前がついているが、イコールが成り立つ x を求めるのではなく、
これが x についての **恒等式** (x に何を入れても成り立つ) になるような y が
どのような x の関数なのかを求める問題である。

解を指数関数と仮定して微分も行うと、

\\[
\begin{eqnarray}
y   &=& e ^ { \lambda x } \\\\
y'  &=&  \lambda e ^ { \lambda x } = \lambda y \\\\
y'' &=& \lambda ^ 2 e ^ { \lambda x } = \lambda ^ 2 y \\\\
\end{eqnarray}
\\]

となり、このまま線形微分方程式に代入してやる。

\\[
\begin{eqnarray}
y'' - y' - y = 0 \\\\
\lambda ^ 2 y - \lambda y - y = 0 \\\\
( \lambda ^ 2 - \lambda - 1 ) y = 0 \\\\
( \lambda ^ 2 - \lambda - 1 ) e ^ { \lambda x } = 0 \\\\
\lambda ^ 2 - \lambda - 1 = 0 \quad ( \because e^{\lambda x} \neq 0) \\\\
\end{eqnarray}
\\]

最後の式がまさに例の高校数学謎解法でも使われる **特性方程式** である。
差分方程式 (漸化式) も微分方程式と同じようなもの (どころか同型) なので
**同じ用語を使う**。

二階の場合は二次方程式になるので、その解は

* 異なる2つの実数解
* 実数の重解
* 異なる2つの虚数解

のいずれかになる。
二つの異なる解があれば \\( y = e ^ { \lambda_1 x}, y = e ^ { \lambda_2 x}\\)
という一次独立な (定数倍でない) 二解が得られるので楽だが、
重解の場合はちょっと (結構？) 困る。
しかし定数変化法で何とかなることは確立しているので安心してよい。

フィボナッチ数列の係数の場合は2つの実数解が得られるので、

\\[
\begin{eqnarray}
y = C e^{ \alpha x } + D e^{ \beta x}
\end{eqnarray}
\\]

これが一般解である (C, D は任意定数)。

ちなみに単振動の場合は

\\[
\begin{eqnarray}
\lambda^2 + \omega^2 = 0 \\\\
\lambda^2 = - \omega^2 \\\\
\lambda = \pm i \omega
\end{eqnarray}
\\]

二つの虚解となる。
複素指数関数は複素数であるので、任意定数も複素数として

\\[
x(t) = C e^{ i \omega t } + D e^{ - i \omega t }
\\]

ただしこれだと x 座標が複素数になってしまうので、実数になるような条件で
絞ってやる必要がある。
オイラーの公式

\\[
e^{ i \theta } = \cos \theta + i \sin \theta
\\]

を使って指数関数の極形式を三角関数の直交座標に直し、虚部が 0 になるよう調整すれば、
2つの任意の複素数、つまり4つの任意の実数が、2つの任意の実数に制約される。

\\[
x(t) = A \sin{ \omega t } + B \cos{ \omega t }
\\]

ここまでやっておいてなんだが、システマティックに複素指数関数の一般解から頑張らなくても、
運動方程式をガン見すればお互いに定数倍でない実数関数の特解2つは見つかる。

\\[
\begin{eqnarray}
x(t) = A \sin{ \omega t } \\\\
x(t) = B \cos{ \omega t }
\end{eqnarray}
\\]

別に sin と cos でないといけないわけではないが、(sin, -sin) のように
位相が 180 度ずれると-1 倍となってしまい、一次独立ではなくなってしまうため注意。

周波数の同じ三角関数の和は、同じ周波数の三角関数になる。
高校数学だと三角関数の合成という名目で加法定理の逆として教えられるが、
これも謎の決まったテクニックとして教えられておりよろしくない。
とにかく任意の振幅で位相差が 0 度や 180 度でない三角関数同士を合成すると、
任意の振幅かつ任意の位相差の三角関数になる。
sin と cos に限定するなら高校数学の三角関数の合成で証明できる。

\\[
\begin{eqnarray}
x(t) = C \sin{ (\omega t + D) }
\end{eqnarray}
\\]

文字が被ってしまったが実数任意定数を置き直した。
微分して代入すればきちんと解になっていることが分かる。

三角関数の中身の時刻 t の係数 \\( \omega \\) が分かれば、
三角関数は 360 度 ( \\( 2 \pi \\) rad ) で一周するので、
振動の一周にかかる時間 (周期) はここまでくれば、

\\[
\begin{eqnarray}
T &=& \frac{ 2 \pi }{ \omega }
  &=& 2 \pi \sqrt{ \frac{m}{k} }
\end{eqnarray}
\\]

と簡単に求められる。
が、これを微積なしの建前で暗記させるのはさすがに無茶が過ぎるようにも感じる。

### 解の補足

特解を探す際に指数関数が解になりそう、と言ったが、よく考えると (よく考えなくても)
指数関数ではなく 0 という x によらない定数関数も条件を満たすことが分かる。
よってこれも立派な微分方程式の解である
(ただし、**自明な解** と呼ばれることもある…)。

\\[
\begin{eqnarray}
  y'' - y' - y = 0 \\\\
  y(x) = 0
\end{eqnarray}
\\]

ただ、これは特解の定数倍を考えたときに

\\[
\begin{eqnarray}
  y = C e^{ \lambda t }
\end{eqnarray}
\\]

ここで \\( C = 0 \\) とすると、これは x に関する指数関数ではなく
定数関数になってしまうが、ちょうど自明な解と一致している。
なので、指数関数にならない \\( C \neq 0 \\) という断りを入れずに
任意の実数とすることで解を合成している。
このあたり、テキストによっては軽く触れられていることもあれば、
完全に省略されてしまっている場合もある。

自然科学 (物理学) は適当にやってみて、何か説明のつかない自然現象が起きてから
よく見直してみたら数学的にまずいことをやっていたのを発見し、
ならばそれを直す、というようなアプローチを取りがちなので、要はいい加減である。
たまに (よく) 物理学者と数学者で衝突が発生しているが、生温かい目で見守っておけばよい。

## 漸化式を線形微分方程式のように解いてみる

\\[
\begin{eqnarray}
  F_{n+2} &=& F_{n+1} + F_{n} \\\\
  F_1 &=& 1 \\\\
  F_2 &=& 1 \\\\
\end{eqnarray}
\\]

* 初めの式は、項間の関係を示している。これは二階線形微分方程式 (同次) に対応し、
  ここから任意定数2つを含む一般解が得られる。
* 残りの式は初期条件である。2つあるのですべての任意定数を消去し、
  解を1つに確定させることができる。

これに線形微分方程式の解法を適用してみよう。

* まず、漸化式をよく見ると、ある数列がこの漸化式を満たす場合、それを定数倍した
  数列もまた解になることが分かる。
* また、ある2つの数列がこの漸化式を満たす場合、それを足したものもまた解になる
  ことが分かる。ただし、2つの式が定数倍の場合は第一の性質で事足りるので除く。
* 証明は難しいが、2つの数列と2つの任意定数で解空間全体を覆いつくすことができる。

となれば、まずは初期条件を無視し、まだ一般解でなくていいので漸化式を満たすような
特解を2つ、なんとかして見つけられないかという話になる。
微分方程式のときは微分すると元の関数の定数倍になるような関数ならよさそう、
そしてそれは指数関数が該当していた。
次の項が今の項の定数倍となるような数列が思い当たる。
そしてそれは等比数列である。
また、その定数倍も条件を満たすが、一般性はまだいらないので初項は適当でよい。
初項を公比と同じにしておけば式が簡単になる。

\\[
\begin{eqnarray}
  y' &=& \lambda y \\\\
  y &=& e^{ \lambda x } \\\\
  F_{n+1} &=& r F_n \\\\
  F_n &=& r^n \\\\
\end{eqnarray}
\\]

では等比数列を漸化式に代入すると

\\[
\begin{eqnarray}
  F_{n+2} - F_{n+1} - F_n &=& 0 \\\\
  F_n &=& r^n \\\\
  r^2 \cdot r^n - r \cdot r^n - r^n &=& 0 \\\\
  (r^2 - r - 1) r^n &=& 0 \\\\
  r^2 - r - 1 &=& 0 \quad (\because r^n \neq 0)
\end{eqnarray}
\\]

これは **特性方程式である** 。
この解 \\( \alpha, \beta \\) を底とした等比数列 (指数関数) は漸化式を満たす。
また、その定数倍も漸化式を満たし、解である。
また、2つの解を足し合わせたものも解である。
(特性方程式の解が整数にならないと検算が大変なので、適当な高校数学の問題で確認するとよい)

\\[
\begin{eqnarray}
  F_{n+2} - F_{n+1} - F_n = 0 \\\\
  F_n = \alpha^n, \ \beta^n \\\\
  F_n = C \cdot \alpha^n, \ D \cdot \beta^n \\\\
  F_n = C \cdot \alpha^n + D \cdot \beta^n \\\\
\end{eqnarray}
\\]

これがフィボナッチ数列から初期条件を取り除いた一般解である。
ここから一般性を取り除くには初期条件が2つ必要で、

\\[
\begin{eqnarray}
  F_n &=& C \cdot \alpha^n + D \cdot \beta^n \\\\
  F_0 &=& 0 = C + D \\\\
  F_1 &=& 1 = \alpha C + \beta D
\end{eqnarray}
\\]

C と D の式が2つあるのでそれぞれ決定できる。

\\[
\begin{eqnarray}
  D &=& -C \\\\
  (\alpha - \beta) C &=& 1 \\\\
  C &=& \frac{1}{ \alpha - \beta } \\\\
  D &=& - \frac{1}{ \alpha - \beta } \\\\
  F_n &=& \dfrac{ 1 }{ \alpha - \beta } ( \alpha ^ n - \beta ^ n ) \\\\
  F_n &=& \dfrac{ 1 }{ \sqrt 5 } \left \\{
    \left ( \dfrac{ 1 + \sqrt{5} }{2} \right ) ^ n -
    \left ( \dfrac{ 1 - \sqrt{5} }{2} \right ) ^ n
  \right \\}
\end{eqnarray}
\\]

高校数学の謎解法と全く同じ解が得られた。

謎解法と言っても、当然この解構造を意識して作られたもので、
解空間全体を網羅できているか明らかでない (示せるが超大変) という弱点を
うまく解消している。
その代わり、特性方程式がどこから出てきたアイデアなのかが全く示されておらず、
テクニックの丸暗記状態となってしまっている。
そもそも高校数学では微分方程式はまったくやらないか、ほんの少し基本的な問題だけ、
という状態なのに、二階線形微分方程式と同型な問題をこっそり解かせているということであり、
どうかと思う。

## 線形代数からのアプローチ

まず漸化式が線形和の形になっているし、線形微分方程式の解も線形代数の考え方が
ベースになっている。
特解を基底とした2次元空間 (指数関数をベクトルのように見なしている) が
解空間となっている。
そもそも線形でない微分方程式などほとんどの場合とてもじゃないが解けやしない。

というわけで、漸化式が線形なのをヒントに、線形代数の言葉で書き直してみる。
線形和はベクトルの内積だと考えて、

\\[
\begin{eqnarray}
  F_{n+2} &=& F_{n+1} + F_n \\\\
  F_{n+2} &=&
    \begin{pmatrix} 1 & 1 \end{pmatrix}
    \begin{pmatrix} F_{n+1} \\\\ F_n \end{pmatrix}
\end{eqnarray}
\\]

(行ベクトルを上の方によせたいが、やり方が分からない。ごめんなさい。)

これで例えば \\( (F_2, F_1) \\) というベクトルに \\( (1, 1) \\) というベクトルを
かける (内積) と、\\( F_3 \\) になる、と考えることができる。
しかし次にやりたいのは \\( F_4 \\) を求めることで、そのためには
\\( (F_3, F_2) \\) に係数ベクトルをかける必要がある。
つまり \\( F_3 \\) だけでなく \\( F_2 \\) も同時に欲しいのだが、
\\( (F_2, F_1) \\) から \\( F_2 \\) への変換はとても簡単で、\\( (1, 0)\\) を
かければよい。
一般化すると

\\[
\begin{eqnarray}
  F_{n+1} &=& 1 \cdot F_{n+1} + 0 \cdot F_n \\\\
  F_{n+1} &=&
    \begin{pmatrix} 1 & 0 \end{pmatrix}
    \begin{pmatrix} F_{n+1} \\\\ F_n \end{pmatrix}
\end{eqnarray}
\\]

2つの変換を合体させて、ベクトル \\( (F_{n+1}, F_n) \\) を
ベクトル \\( (F_{n+2}, F_{n+1}) \\) に **行列** をかけて変換すると
考えることができる。

\\[
\begin{eqnarray}
  \begin{pmatrix} F_{n+2} \\\\ F_{n+1} \end{pmatrix} =
  \begin{pmatrix} 1 && 1 \\\\ 1 && 0 \end{pmatrix}
  \begin{pmatrix} F_{n+1} \\\\ F_n \end{pmatrix}
\end{eqnarray}
\\]

つまり、この行列 \\( \begin{pmatrix} 1 && 1 \\\\ 1 && 0 \end{pmatrix} \\) は、
フィボナッチ数列の隣り合う2項からなるベクトルを、1つ隣の2項からなるベクトルへ
一次変換するものだと考えることができる。
またこの式は、スカラーの等比数列からベクトルの等比数列への
自然な拡張とみなすことができる。公比にあたるものは行列となっている。

行列を1回かけると数列の添え字が1つ増えることから、

\\[
\begin{eqnarray}
  \begin{pmatrix} F_{n+1} \\\\ F_{n} \end{pmatrix} =
  \begin{pmatrix} 1 && 1 \\\\ 1 && 0 \end{pmatrix} ^n
  \begin{pmatrix} F_1 \\\\ F_0 \end{pmatrix}
\end{eqnarray}
\\]

と一般に表せる。
ここで律儀にベクトルに行列を左からかける、という操作を n 回行う必要はない。
行列のかけ算は左右を入れ替えてはいけないが、どちらから先に計算するかは変えてもよい。
一次変換の一次変換はまた一次変換である、ということで、それが行列の積の計算規則でもある。
要は行列の n 乗の部分だけ先に積を計算できれば、初項ベクトルにそれを左からかけるだけで
一般解とできそうである。

さて、\\( \begin{pmatrix} 1 && 1 \\\\ 1 && 0 \end{pmatrix} ^n \\) を
計算できそうか、という話になったが、別の解法により答えは大体分かっており、
あまり簡単には表せない気がする。
試しに2乗や3乗を計算してみても、各要素にフィボナッチ数列のようなものが
現れるだけ (当たり前) で、これを眺めていてもフィボナッチ数列を眺めて
直接一般項を出そうとするのと話は変わらない。

\\[
\begin{eqnarray}
  \begin{pmatrix} 1 && 1 \\\\ 1 && 0 \end{pmatrix}
  \begin{pmatrix} 1 && 1 \\\\ 1 && 0 \end{pmatrix} =
  \begin{pmatrix} 2 && 1 \\\\ 1 && 1 \end{pmatrix} \\\\
  \begin{pmatrix} 2 && 1 \\\\ 1 && 1 \end{pmatrix}
  \begin{pmatrix} 1 && 1 \\\\ 1 && 0 \end{pmatrix} =
  \begin{pmatrix} 3 && 2 \\\\ 2 && 1 \end{pmatrix} \\\\
  \begin{pmatrix} 3 && 2 \\\\ 2 && 1 \end{pmatrix}
  \begin{pmatrix} 1 && 1 \\\\ 1 && 0 \end{pmatrix} =
  \begin{pmatrix} 5 && 3 \\\\ 3 && 2 \end{pmatrix} \\\\
\end{eqnarray}
\\]

行列の n 乗を簡単に求められるようにする方法として、線形代数の授業内容に
大抵入っている **対角化** という手法が有効である。
対角行列のべき乗は

\\[
\begin{eqnarray}
  \begin{pmatrix} \alpha & 0 \\\\ 0 & \beta \end{pmatrix}
  \begin{pmatrix} \alpha & 0 \\\\ 0 & \beta \end{pmatrix} =
  \begin{pmatrix} \alpha^2 & 0 \\\\ 0 & \beta^2 \end{pmatrix} \\\\
  \begin{pmatrix} \alpha & 0 \\\\ 0 & \beta \end{pmatrix} ^n =
  \begin{pmatrix} \alpha^n & 0 \\\\ 0 & \beta^n \end{pmatrix} \\\\
\end{eqnarray}
\\]

という風に非常に簡単に計算できる。
そもそも対角行列がどういうものかというと、

\\[
\begin{eqnarray}
  \begin{pmatrix} \alpha & 0 \\\\ 0 & \beta \end{pmatrix}
  \begin{pmatrix} x \\\\ y \end{pmatrix} =
  \begin{pmatrix} \alpha x \\\\ \beta y \end{pmatrix} \\\\
\end{eqnarray}
\\]

x と y をそれぞれ単純に定数倍するような行列のことである
(拡大縮小を表すので 3D グラフィクスではスケーリング行列と呼ばれることもある)。
もちろんフィボナッチ数列の前進行列はこのような都合のいい形をしていないので、
なんとかしてこの形に持ち込めないかを考えてみる。

### 固有値と固有ベクトル

さて、ある行列が与えられたとき、ある方向のベクトルにその行列をかけたときに
ベクトルの方向が変わらず単にスカラー定数倍になる場合がある。
その方向ベクトルを **固有ベクトル** といい、その倍率を **固有値** と呼ぶ。
名前の通り、その行列の性質を表す非常に重要な方向や倍率である。
この単なる定数倍というところが今の課題にうまく使えそうな気がする。
線形代数の授業ではよく分からないままとりあえず求め方を訓練させられるので、
とりあえずフィボナッチ数列の行列の固有ベクトルと固有値を求めてみよう。
求め方はシステム化されていて、あるベクトルに与えられた行列をかけたら
単なるベクトルのスカラー倍になったという条件から、

\\[
\begin{eqnarray}
  A \boldsymbol{v} &=& \lambda \boldsymbol{v} \\\\
  A \boldsymbol{v} &=& \lambda E \boldsymbol{v} \\\\
  (A - \lambda E) \boldsymbol{v} &=& \boldsymbol{0} \\\\
  \left (
  \begin{pmatrix} 1 & 1 \\\\ 1 & 0 \end{pmatrix} -
  \begin{pmatrix} \lambda & 0 \\\\ 0 & \lambda \end{pmatrix}
  \right)
  \boldsymbol{v} &=& \boldsymbol{0} \\\\
  \begin{pmatrix} 1 - \lambda & 1 \\\\ 1 & - \lambda \end{pmatrix}
  \boldsymbol{v} &=& \boldsymbol{0} \\\\
\end{eqnarray}
\\]

ここで \\( \boldsymbol{v} \\) で括りたかったが、行列とスカラーは直接足し算引き算が
できないので、単位行列を補って行列同士の減算に書き換えるテクニックを使った。

左辺の行列に逆行列が存在すると仮定すると、両辺に左からその逆行列をかけることができ、
\\( \boldsymbol{v} = \boldsymbol{0} \\) という解のみになってしまう。
今固有ベクトルとして欲しいのは方向ベクトルであり、方向のないゼロベクトルは
不適である (固有ベクトルの定義式を満たしはするが、固有ベクトルの定義に含めない)。
つまり、(ゼロでない) 固有ベクトルが存在するならば、
この行列は正則でないという必要条件が得られる。
行列が正則であるということの必要十分条件は非常によく研究されており、
その中の「行列式がゼロならば正則ではない (逆も成り立つ)」という条件を使うと

\\[
\begin{eqnarray}
  \begin{vmatrix} 1 - \lambda & 1 \\\\ 1 & - \lambda \end{vmatrix} = 0 \\\\
  (1 - \lambda)(- \lambda) - 1 \cdot 1 = 0 \\\\
  \lambda^2 - \lambda - 1 = 0
\end{eqnarray}
\\]

これは2次方程式であり、この解が固有値となる (本当は十分性を確認しなければならないが、
結論から言うと固有値になる)。
このように固有値を解に持つ多項式を **固有方程式** と呼ぶ。
一般に n 次正方行列の固有方程式は n 次方程式になり、複素数の範囲かつ重解を別個に
カウントすれば、解は n 個ある。
今回は 2x2 行列なので 2 次方程式になっている。
形が完全に特性方程式と同じになっていることから、解も同じで

\\[
\begin{eqnarray}
  \lambda^2 - \lambda - 1 = 0 \\\\
  (\lambda - \alpha)(\lambda - \beta) = 0 \\\\
  \lambda^2 - (\alpha + \beta) \lambda - \alpha \beta = 0 \\\\
  \alpha, \beta = \frac{ 1 \pm \sqrt 5 }{2} \\\\
  \alpha + \beta = 1 \\\\
  \alpha \beta = -1 \\\\
\end{eqnarray}
\\]

つまりフィボナッチ数列を表す行列の固有値は \\( \alpha, \beta \\) の2つである。
\\( \lambda = \alpha \\) を代入し、行列がランク落ちしていること
(連立一次方程式として見たときに実質的に同じ式が2つ並んでいること。
正則でないことと同値。) と、
特性方程式より和が 1 で積が -1 であることに気を付けつつ整理すると

\\[
\begin{eqnarray}
  \begin{pmatrix} 1 - \alpha & 1 \\\\ 1 & - \alpha \end{pmatrix}
  \boldsymbol{v} &=& \boldsymbol{0} \\\\
  \begin{pmatrix} \beta & 1 \\\\ 1 & \frac{1}{\beta} \end{pmatrix}
  \begin{pmatrix} x \\\\ y \end{pmatrix} &=& \boldsymbol{0} \\\\
  \beta x + y = 0 \\\\
  y = k \Rightarrow x = - \frac{1}{\beta} k = \alpha k \\\\
  \boldsymbol{v} = k \begin{pmatrix} \alpha \\\\ 1 \end{pmatrix}
\end{eqnarray}
\\]

つまり、\\( (\alpha, 1) \\) に平行なベクトルに行列 A をかけると方向は変わらず、
単に \\( \alpha \\) 倍になるということである。
固有値 \\( \beta \\) についても同様に、固有ベクトル \\( (\beta, 1) \\)
(の定数倍) を得る。

### 基底

\\( (\alpha, 1) \\) と \\( (\beta, 1) \\) という方向をベースに考えると
よいのではないか、というアイデアが得られた。

ここで座標という考え方を改めて見直してみる。

\\[
\begin{eqnarray}
  \begin{pmatrix} x \\\\ y \end{pmatrix} =
  x \begin{pmatrix} 1 \\\\ 0 \end{pmatrix} +
  y \begin{pmatrix} 0 \\\\ 1 \end{pmatrix}
\end{eqnarray}
\\]

式自体はあまりにも当たり前のものになっているが、これは座標 \\( (x , y) \\) を
\\( (1, 0) \\) の方向に \\( x \\) 倍だけ、\\( (0, 1) \\) の方向に \\( y \\) 倍だけ
進んだ先のこととする、という気持ちを表している。
この2つのベクトルのことを **基底** といい、すべての長さが1のとき **正規**、
お互いに垂直のとき **直交** をつけて、**正規直交基底** という。
この例は正規直交基底である。

ここでのアイデアは、基底は正規でも直交でもなくても構わないのではないか？
というところにある。
実際、2次元平面を覆いつくすには正規でも直交でもなくてもいいので
**平行でない** (**一時独立**な) ベクトルが2本あれば十分である
(むしろ正確には必要な基底ベクトルの数を **次元** と定義する)。
垂直でない規定による座標系を **斜交座標系** と言ったりする。

例えば A の固有ベクトルは平行ではないので、任意の正規直交基底による座標は

\\[
\begin{eqnarray}
  \begin{pmatrix} x \\\\ y \end{pmatrix} &=&
  x' \begin{pmatrix} \alpha \\\\ 1 \end{pmatrix} +
  y' \begin{pmatrix} \beta  \\\\ 1 \end{pmatrix} \\\\
  &=&
  \begin{pmatrix} \alpha & \beta \\\\ 1 & 1 \end{pmatrix}
  \begin{pmatrix} x' \\\\ y' \end{pmatrix}
\end{eqnarray}
\\]

のように書ける。
これは斜交座標 (x', y') を決めると正規直交座標 (x, y) が一意に決まるという
気持ちを表している。
行列で表せていることから、この **座標変換** は **一次変換** であることが分かる。

さらに、 \\( (\alpha, 1), (\beta, 1) \\) は平行ではないから
この変換行列は正則で逆行列が存在し、それを両辺に左からかけると

\\[
\begin{eqnarray}
  \begin{pmatrix} \alpha & \beta \\\\ 1 & 1 \end{pmatrix} ^{-1}
  \begin{pmatrix} x \\\\ y \end{pmatrix} =
  \begin{pmatrix} x' \\\\ y' \end{pmatrix}
\end{eqnarray}
\\]

とも表せる。
これは (x, y) から (x', y') への変換も同様に **一次変換** であるということを
表している。

### 対角化

固有値と座標変換 (基底の変換) を組み合わせて考えてみよう。
まず元の正規直交基底による座標を、固有ベクトルを基底とする座標系に変換してやる。

\\[
\begin{eqnarray}
  \begin{pmatrix} x' \\\\ y' \end{pmatrix} =
  \begin{pmatrix} \alpha & \beta \\\\ 1 & 1 \end{pmatrix} ^{-1}
  \begin{pmatrix} x \\\\ y \end{pmatrix}
\end{eqnarray}
\\]

この座標系に対して、フィボナッチ数列の行列 A を左からかけてみる
(スカラー倍に関してはかけ算の左右を交換しても問題ない)。

\\[
\begin{eqnarray}
  \begin{pmatrix} x \\\\ y \end{pmatrix} &=&
  x' \begin{pmatrix} \alpha \\\\ 1 \end{pmatrix} +
  y' \begin{pmatrix} \beta  \\\\ 1 \end{pmatrix} \\\\
  A \begin{pmatrix} x \\\\ y \end{pmatrix} &=&
  x' A \begin{pmatrix} \alpha \\\\ 1 \end{pmatrix} +
  y' A \begin{pmatrix} \beta  \\\\ 1 \end{pmatrix} \\\\
\end{eqnarray}
\\]

ここで、基底を固有ベクトルに取ったことが生きてくる。
固有ベクトルとはその方向に行列をかけたら対応する固有値 (スカラー) 倍になるという
ものだったから、行列 A の代わりに固有値倍となって、

\\[
\begin{eqnarray}
  A \begin{pmatrix} x \\\\ y \end{pmatrix} &=&
  x' A \begin{pmatrix} \alpha \\\\ 1 \end{pmatrix} +
  y' A \begin{pmatrix} \beta  \\\\ 1 \end{pmatrix} \\\\
  &=&
  x' \alpha \begin{pmatrix} \alpha \\\\ 1 \end{pmatrix} +
  y' \beta  \begin{pmatrix} \beta  \\\\ 1 \end{pmatrix} \\\\
  &=&
  \alpha x' \begin{pmatrix} \alpha \\\\ 1 \end{pmatrix} +
  \beta  y' \begin{pmatrix} \beta  \\\\ 1 \end{pmatrix} \\\\
\end{eqnarray}
\\]

これは (x, y) に左から A をかけるということは、
(x', y') 座標系では単に x' を \\( \alpha \\) 倍、y' を \\( \beta \\) 倍するだけ
であるということを示している。
(x', y') 座標系ではこの変換を行列表現すると

\\[ \begin{pmatrix} \alpha & 0 \\\\ 0 & \beta \end{pmatrix} \\]

である。
これを用いて (x, y) に左から行列 A をかけるのを以下のように表現する。

1. 与えられた (x, y) を一次変換し、(x', y') に座標変換する。
1. \\( (x', y') \\) を \\( (x'', y'') = (\alpha x', \beta y') \\) に変換する。
  この変換は対角行列
  \\( \begin{pmatrix} \alpha & 0 \\\\ 0 & \beta \end{pmatrix} \\)
  で表される。
  これは (x, y) 座標系では行列 A を左からかけているのに相当する。
1. 移動後の (x'', y'') を逆変換し、(x', y') に直したものが求める答えとなる。

固有ベクトルを基底とする座標系への変換行列を \\( P^{-1} \\) とすると、
これらの操作は以下のように表せる。

\\[
\begin{eqnarray}
  A \begin{pmatrix} x \\\\ y \end{pmatrix} &=&
  P
  \begin{pmatrix} \alpha & 0 \\\\ 0 & \beta \end{pmatrix}
  P^{-1}
  \begin{pmatrix} x \\\\ y \end{pmatrix}
\end{eqnarray}
\\]

1. (x, y) に左から P の逆行列をかけて固有ベクトルによる斜交座標に変換
1. 固有ベクトルの性質より、固有値による単純なスケーリング変換を左からかける
1. 左から P をかけて元の正規直交座標に戻す

ここで、左から A を何度もかけることを考えると、行列とその逆行列との積は
単位行列になることに注意して、

\\[
\begin{eqnarray}
  A A \begin{pmatrix} x \\\\ y \end{pmatrix} &=&
  P
  \begin{pmatrix} \alpha & 0 \\\\ 0 & \beta \end{pmatrix}
  P^{-1}
  P
  \begin{pmatrix} \alpha & 0 \\\\ 0 & \beta \end{pmatrix}
  P^{-1}
  \begin{pmatrix} x \\\\ y \end{pmatrix} \\\\
  &=&
  P
  \begin{pmatrix} \alpha & 0 \\\\ 0 & \beta \end{pmatrix} ^2
  P^{-1}
  \begin{pmatrix} x \\\\ y \end{pmatrix} \\\\
  A^n \begin{pmatrix} x \\\\ y \end{pmatrix}
  &=&
  P
  \begin{pmatrix} \alpha & 0 \\\\ 0 & \beta \end{pmatrix} ^n
  P^{-1}
  \begin{pmatrix} x \\\\ y \end{pmatrix} \\\\
  &=&
  P
  \begin{pmatrix} \alpha^n & 0 \\\\ 0 & \beta^n \end{pmatrix}
  P^{-1}
  \begin{pmatrix} x \\\\ y \end{pmatrix}
\end{eqnarray}
\\]

教科書的に書くとこうだが、新しい座標系の中でスケーリングしたのち、
元の座標系に戻し、また新しい座標系に変換してスケーリングするのは無駄なので、

1. 新しい座標系に変換する
2. n 回スケーリングする
3. 元の座標系に戻す

の方が早いよね、というだけのことである。

これはもう解けており、具体的な値を代入すれば、

\\[
\begin{eqnarray}
  F_0 = 0 \\\\
  F_1 = 1 \\\\
\end{eqnarray}
\\]

\\[
\begin{eqnarray}
  \alpha &=& \dfrac{ 1 + \sqrt{5} }{2} \\\\
  \beta  &=& \dfrac{ 1 - \sqrt{5} }{2}
\end{eqnarray}
\\]

\\[
\begin{eqnarray}
  P &=& \begin{pmatrix} \alpha & \beta \\\\ 1 & 1 \end{pmatrix} \\\\
  P^{-1}
  &=&
  \frac{1}{|P|} \begin{pmatrix} 1 & -\beta \\\\ -1 & \alpha \end{pmatrix} \\\\
  &=&
  \frac{1}{\alpha - \beta}
  \begin{pmatrix} 1 & -\beta \\\\ -1 & \alpha \end{pmatrix}
\end{eqnarray}
\\]

\\[
\begin{eqnarray}
  \begin{pmatrix} F_{n+1} \\\\ F_n \end{pmatrix}
  &=&
  A^n \begin{pmatrix} F_1 \\\\ F_0 \end{pmatrix} \\\\
  &=&
  P
  \begin{pmatrix} \alpha^n & 0 \\\\ 0 & \beta^n \end{pmatrix}
  P^{-1}
  \begin{pmatrix} F_1 \\\\ F_0 \end{pmatrix} \\\\
  &=&
  \begin{pmatrix} \alpha & \beta \\\\ 1 & 1 \end{pmatrix}
  \begin{pmatrix} \alpha^n & 0 \\\\ 0 & \beta^n \end{pmatrix}
  \frac{1}{\alpha - \beta}
  \begin{pmatrix} 1 & -\beta \\\\ -1 & \alpha \end{pmatrix}
  \begin{pmatrix} 1 \\\\ 0 \end{pmatrix} \\\\
  &=&
  \frac{1}{\alpha - \beta}
  \begin{pmatrix}
    \alpha^{n+1} - \beta^{n+1} &
    - \alpha^{n+1} \beta + \alpha \beta^{n+1} \\\\
    \alpha^n - \beta^n &
    - \alpha^n \beta + \alpha \beta^n
  \end{pmatrix}
  \begin{pmatrix} 1 \\\\ 0 \end{pmatrix} \\\\
  &=&
  \frac{1}{\alpha - \beta}
  \begin{pmatrix}
    \alpha^{n+1} - \beta^{n+1} \\\\
    \alpha^n - \beta^n
  \end{pmatrix} \\\\
  F_n
  &=&
  \frac{1}{\alpha - \beta} (\alpha^n - \beta^n) \\\\
  &=&
  \frac{ 1 }{ \sqrt 5 } \left \\{
    \left ( \frac{ 1 + \sqrt{5} }{2} \right ) ^ n -
    \left ( \frac{ 1 - \sqrt{5} }{2} \right ) ^ n
  \right \\}
\end{eqnarray}
\\]

### 余談

行列の n 乗の形に持っていけている時点で、それが対角化されていなくても
繰り返し二乗法を適用することで比較的少ない計算量で値を直接計算することができる。
一般解が求まれば n を代入するだけで計算量 \\( O (1) \\) で \\( F_n \\) が求まるが、
それができなくても、

\begin{eqnarray}
  a^8 &=& a^4 \cdot a^4 \\\\
  a^4 &=& a^2 \cdot a^2 \\\\
  a^2 &=& a \cdot a \\\\
\end{eqnarray}

のように n 乗はより小さな n/2 乗を求めるという部分問題の解を使って
(漸化式や数学的帰納法の考え方) 高速に求めることができる(**分割統治法**)。
計算量は \\( O(\log n) \\) になる (底は 2)。
これは行列のべき乗にもそのまま適用できる。
このテクニックは行列累乗と呼ばれるが、競プロの中でだけかもしれない。
\\( \log_2 n \\) は指数関数の逆関数であり、まったく大きくならないので、
それなりの大きさの n に関しては実用上、ほぼ定数として扱える。

\begin{eqnarray}
  2^8 &=& 256 \\\\
  log_2 256 &=& 8 \\\\
  2^{16} &=& 65536 \\\\\
  log_2 65536 &=& 16 \\\\
  2^{32} &=& 4294967296 \\\\
  log_2 4294967296 &=& 32 \\\\
\end{eqnarray}
