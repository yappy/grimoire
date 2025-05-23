# フーリエ変換

* 自然に思いつくことはほぼ不可能と思われるが、理工学では一般常識。
  * 最近のトレンドでは裁判官の間でも一般常識らしい。本当かどうかは不明。
* 一般常識かどうかは諸説あるが、一般常識として持っておくと生活が豊かになる。
* 正直数学がキツいところはあるというか、高校範囲外なのは事実である。
* ただし概要やできることを知っているだけでも相当価値がある。

できることの例

* 音声データを周波数成分ごとに分解できる。それを元の音声信号に戻すこともできる。
  * ボーカルをカットしてカラオケ用のデータを自作する方法がこれ。
* 可逆圧縮のほとんど効かない写真画像や音声データを効率的に圧縮できる。
  * jpeg や音声、動画圧縮の中身の基本はこれ。
* 一筆書き (x(t), y(t)) を t でフーリエ変換すると円運動するベクトルの足し算で
  表現できる。見た目が面白いのでググってみよう。

## 波の基本

実際のところ、対象は音などの時間で変化する信号だけに限らない。
例えば、時間の代わりに画像ファイルの座標を使う、など (jpeg や動画の圧縮に使うよ)。
ただし用語の使い方も時間信号で考えた用語をそれ以外を対象にする場合も気にせずそのまま
使っている感じのため、とりあえず時間変化する信号と考えておき、
それ以外にも適用可能なことだけ気を付けておけばよい。

とりあえず sin (cos) 波を考える。
X - Y の順に対応するのは cos - sin なので cos (sin) 波とした方がよいのかもしれない。
いずれにしろ、sin と cos は横方向に平行移動しただけで全く同じ形の波なので、
初期位相を (90 度分) ずらせばいくらでも変換できる。

三角関数が最も基本的な波だから、とか、発電所ではタービンを円運動させているので
コンセントには sin 波が来ているから、とか適当なことを言って (きちんとした事実だが)
ごまかしながら導入するが、本当の理由は
「三角関数とは全然違う波だとしても、三角関数の重ね合わせとして分解できるから」
である。
例えば、太陽光 (電磁波) なんかは全く三角関数の形をしていない。
三角関数が最も基本的な波なのは事実で、使える数学のツールも非常に多い。
なので、三角関数でないものが三角関数だけの和で表せるのは超重要な事実である。

$$
\begin{aligned}
  f(t) &= A \sin (\omega t + \phi) \\\\
  f(t) &= A \sin (2 \pi f t + \phi) \\\\
  f(t) &= A \sin ( \frac { 2 \pi } { T } t + \phi) \\\\
  f &= 1 / T \\\\
  \omega &= \frac { 2 \pi } { T } = 2 \pi f \\\\
\end{aligned}
$$

* 振幅 (amplitude)
  * 三角関数の定数係数。波の振れ幅。
  * 三角関数は -1 から 1 の範囲をふわふわするので、
    \\( -A \le f(t) \le A \\)
    の範囲で変化する波を表すことになる。
    単位は波によって色々。音声信号なら音圧など。
* 位相 (phase)
  * 三角関数の中身。単位は角度 (rad など)。
  * 360 度 ( \\( 2 \pi \\) rad) を一周期としたとき、その中のどのポイントにいるかを
    角度で示したもの。
* 波の変化速度 (相互変換可能)
  * 角周波数 (angular frequency) \\( \omega \\)
    * 三角関数内の時間に係数をつける形で \\( \omega t \\) のようにしたもの。
    * 単位は (角度 / 時間) で、rad / s 等。
      時間に掛け算すると角度となり三角関数に入れられる。
    * 単位時間あたり、一周期を 360 度とした割合で何度分進むか。
    * 合成関数の微分積分でそのまま外に出てくるため、数式処理する場合に一番読みやすい。
  * 周期 \\( T \\)
    * 繰り返しの一回分に何秒かかるか。分かりやすい。
    * 単位は時間。s。
  * 周波数 \\( f \\)
    * 1秒に何回繰り返されるか。こちらも分かりやすい。周期とお互いに逆数の関係にある。
    * 単位は 1/s。Hz (ヘルツ) の方をよく使う。

単位は時間変化する信号の場合を例として書いたが、時間を座標にすると
画像を対象にできたりする。
ただし同時に変数を2変数にする必要は出てくる。

## フーリエ級数展開 (実数)

* 三角関数とは似ても似つかないが、周期 T で繰り返してはいる信号があるとする。
* そんな都合よく周期 T でずっと繰り返す信号ばかりじゃない (例: 音声ファイル)、
  と思うかもしれないが、その場合は音声ファイルの長さを T とし、
  左右に無限回コピペし続ければ周期 T の信号と言えなくもない。
* これが苦しい言い訳に聞こえて仕方ない場合は、フーリエ変換まで我慢する。

驚くべき事実として、周波数
\\( f = 1/T \\)
の任意 (本当に任意とは言っていない) の信号は、周波数
\\( f, 2f, 3f, 4f, 5f, \ldots \\)
の三角関数の無限個の和に分解できる (ことが多い)。
もともとかなり無茶なことをしようとしているので、数学的に厳密な議論をしようとすると
とんでもないことになる (Wikipedia 参照) ため、数学徒以外は無理をしてはいけない。

式で書くときは角周波数で書いた方が目に優しいため、基本角周波数を
\\( \omega _0 = \frac { 2 \pi } { T } \\)
とし、その整数倍の角周波数の三角関数を考える。
周波数のみを固定したとき、振幅と初期位相の2つが自由に決められるパラメータとなるから

$$
\begin{aligned}
C_1 & \sin ( 1 \omega _0 t + D_1 ) \\\\
C_2 & \sin ( 2 \omega _0 t + D_2 ) \\\\
C_3 & \sin ( 3 \omega _0 t + D_3 ) \\\\
\ldots \\\\
C_k & \sin ( k \omega _0 t + D_k )\\\\
\ldots
\end{aligned}
$$

のような波を重ね合わせることになる。
1つを選んで加法定理を使って変形すると、

$$
\begin{aligned}
& C_k \sin ( k \omega _0 t + D_k ) \\\\
&= C_k ( \sin k \omega _0 t \cos D_k + \cos k \omega _0 t \sin D_k) \\\\
&= (C_k \cos D_k) \sin k \omega _0 t + (C_k \sin D_k) \cos k \omega _0 t \\\\
&= A_k \sin k \omega _0 t + B_k \cos k \omega _0 t
\end{aligned}
$$

のようになる。
つまり、基本周波数の k 倍の sin および cos を適切な倍率でブレンドして
足し合わせていくと、(それなりの条件が満たされていれば)目的の関数に
近づいていくということである。

任意の A, B (sin の振幅と cos の振幅) を決めるのは
任意の C, D (1つの三角関数の振幅と位相) を決めるのと同じ、
という順番で説明されることが多いが、それは三角関数の合成を根拠にされる。
三角関数の合成は加法定理の逆をやっているだけなので、
とにかく2つの表現はどちらも同じことである。

それでは、係数の決め方を説明する。
以下は A, B (sin, cos の振幅) を決めることができる方法であるが、
実質的に C, D (振幅と初期位相) を決めるのと同じことである。

ここでちょっと準備をする。
なぜか高校数学ではあまり注目されない気もするが、以下の事実がある。

$$
\begin{aligned}
n, m = 1, 2, 3, \ldots \\\\
\int_0^{2 \pi} \sin n t \sin m t dt &= 0 \quad (n \ne m) \\\\
\int_0^{2 \pi} \cos n t \cos m t dt &= 0 \quad (n \ne m) \\\\
\int_0^{2 \pi} \sin n t \cos m t dt &= 0 \quad \\\\
\end{aligned}
$$

整数倍の周波数の sin や cos について、周波数の異なるもの同士を掛けたもの、
または周波数が同じだとしても sin と cos を掛けたものは
基本周期で積分すると 0 になる。
見た目がゴツいので n, m にいくつかの値を代入した例を書き下すと

$$
\begin{aligned}
\int_0^{2 \pi} \sin ^2 2t dt &\ne 0 \\\\
\int_0^{2 \pi} \cos ^2 5t dt &\ne 0 \\\\
\int_0^{2 \pi} \sin t \sin 3 t dt &= 0 \\\\
\int_0^{2 \pi} \cos 5 t \cos 8 t dt &= 0 \\\\
\int_0^{2 \pi} \sin 2 t \cos 2 t dt &= 0 \\\\
\end{aligned}
$$

のような感じである。

証明はただ積分を計算するだけだが、積を積分するのは難しいので和の形に変形する
(三角関数は使える道具が多い)。
一言で言うと倍角半角の公式、積和の公式なのだが、要は加法定理をいじって
積を和に変換する式を作るだけである。

cos の加法定理において同一の角度 ( \\( \beta = \alpha \\) ) とすると、
sin や cos の2乗を cos の1乗の形にできる。

$$
\begin{aligned}
\cos (\alpha + \alpha) &= \cos \alpha \cos \alpha - \sin \alpha \sin \alpha \\\\
\cos 2 \alpha &= \cos ^2 \alpha - \sin ^2 \alpha
\end{aligned}
$$

これと三角関数の基本公式、というよりは三角関数の定義そのもの

$$
\begin{aligned}
\sin ^2 \alpha + \cos ^2 \alpha = 1 \\\\
\sin ^2 \alpha = 1 - \cos ^2 \alpha \\\\
\cos ^2 \alpha = 1 - \sin ^2 \alpha \\\\
\end{aligned}
$$

を使って2乗のうちの片方を消去すれば

$$
\begin{aligned}
\cos 2 \alpha &= 1 - 2 \sin ^2 \alpha \\\\
\cos 2 \alpha &= 2 \sin ^2 \alpha - 1 \\\\
\end{aligned}
$$

ちょっと変形してやれば積分できなくて困っていた三角関数の2乗を
簡単に積分にできる1乗と定数の形に変換する式を作れる。

$$
\begin{aligned}
\sin ^2 \alpha = \frac{1}{2} ( 1 - \cos 2 \alpha ) \\\\
\cos ^2 \alpha = \frac{1}{2} ( 1 + \cos 2 \alpha ) \\\\
\end{aligned}
$$

どちらの変換方向が倍角か半角かなんて覚えられないし、調べるとこの形は半角公式らしいが、
半分の角度の sin, cos ならよく知っているので角度を半分にしたい、という動機ではなく、
積分できる形に変形するため2乗を1乗に落としたいだけである。

右辺をよく見ると \\( \cos 2 \alpha \\) の部分は周期 (の整数倍) の長さの区間で
積分すると 0 になるから、定数 \\( \frac{1}{2} \\) と周期をかけたものだけが残り、
0 にはならない。
なお、交流に抵抗のみをつないだ時の電圧と電流の積 (つまり、消費電力) も、
同じ三角関数の2乗の形になる。
消費されるエネルギーの時間平均から実効値を求める時の積分計算も同じように計算できる。

sin の加法定理をよく見ると三角関数の積が右辺にある。
プラスマイナスの2つの式を上下に並べて辺々足し算 (または引き算) すれば
sin と cos の積を和に直せる。

$$
\begin{aligned}
\sin (\alpha + \beta) &= \sin \alpha \cos \beta + \cos \alpha \sin \beta \\\\
\sin (\alpha - \beta) &= \sin \alpha \cos \beta - \cos \alpha \sin \beta \\\\
\sin (\alpha + \beta) + \sin (\alpha - \beta) &= 2 \sin \alpha \cos \beta
\end{aligned}
$$

右辺が今積分できずに困っている形、左辺は楽に積分できる形になっている。

cos の加法定理を辺々いい感じに足したり引いたりすれば、
sin 同士または cos 同士の積を和に直せる。

$$
\begin{aligned}
\cos (\alpha - \beta) &= \cos \alpha \cos \beta + \sin \alpha \sin \beta \\\\
\cos (\alpha + \beta) &= \cos \alpha \cos \beta - \sin \alpha \sin \beta \\\\
2 \sin \alpha \sin \beta &= \cos (\alpha - \beta) - \cos (\alpha + \beta) \\\\
2 \cos \alpha \cos \beta &= \cos (\alpha - \beta) + \cos (\alpha + \beta) \\\\
\end{aligned}
$$

* \\( \sin 0 = 0 \\)
  * 当然これをどこからどこまで積分してもゼロ
* \\( \cos 0 = 1 \\)
  * これを周期 (0でない) で積分したら非ゼロ
* \\( \sin n \pi \\) や \\( \cos n \pi \\)
  * 周期の中で三角関数が n 周しているだけだから、周期での平均はゼロ、
    つまり積分したらゼロ
  * ただし \\( n = 0 \\) の場合は除く。
    * このケースは上で議論済み。三角関数ではなく定数関数になる。
  * n が負の場合は含む。

準備が完了したので、まずは変換したい関数が以下のように **展開できた** と仮定する。

$$
\begin{aligned}
f(t) &\sim A_0 +
A_1 \cos \omega _0 t + B_1 \sin \omega _0 t +
A_2 \cos 2 \omega _0 t + B_2 \sin 2 \omega _0 t + \dots \\\\
&= A_0 +
\sum _{k=1}^{\infty}
( A_k \cos k \omega _0 t + B_k \sin k \omega _0 t )
\end{aligned}
$$

本当にこんなことをしていいのか定かでない、かなりやばいことをしているので
本物のイコールで結ぶのはさすがにどうかという気持ちを表すのにニョロ記号を使うことがある。

まずは \\( A_0 \\) を求める。
おもむろに両辺を基本周期で積分してみると、右辺の三角関数の項はすべて基本周波数の
整数倍の周波数を持つ三角関数であるため、積分値はゼロになる。
したがって三角関数の項はすべて消えて、

$$
\begin{aligned}
\int_0^{T_0} f(t) dt &= \int_0^{T_0} A_0 dt \\\\
&= A_0 T_0 \\\\
A_0 &= \frac{1}{T_0} \int_0^{T_0} f(t) dt
\end{aligned}
$$

信号を基本周期で積分して出てきた面積を基本周期で割っている。
これは信号の基本周期あたりの平均値である。
三角関数は周期あたりで平均するとゼロであるため、どれだけ足し算しても平均がゼロの
信号しか作れない。
そこを何とかするために振動中心をこの値にセットしていると理解できる。
また、この定数値を直流成分とも呼ぶ。
電気信号をフーリエ変換すると時間に対する定数関数 (直流) と三角関数 (交流) の和に
分解できることから来ている。

では本題の各三角関数の係数はというと、おもむろに欲しい項と同じ周波数と種類の
三角関数を掛けてから基本周期で積分する。
直流成分に三角関数を掛けた分は三角関数の定数倍となるので、
基本周期で積分すればゼロとなる。
同じ周波数で sin または cos の場合は非ゼロとなり、この項が残る。
それ以外は事前準備で見てきたように、全てゼロとなる。
sin や cos の2乗は倍角半角で次数を落として計算する。

$$
\begin{aligned}
\int _0^T f(t) \cos 2 \omega_0 t dt
&= \int _0^T A_0 \cos 2 \omega_0 t dt +
\int _0^T ( \sum _{k=1}^{\infty}
( A_k \cos k \omega _0 t + B_k \sin k \omega _0 t ) ) \cos 2 \omega_0 t dt \\\\
&= A_2 \int _0 ^T \cos ^2 2 \omega _0 t dt \\\\
&= A_2 \cdot \frac{T}{2} \\\\
A_2 &= \frac{2}{T} \int _0^T ( \cos 2 \omega_0 t ) f(t) dt \\\\
\end{aligned}
$$

基本周波数の k 倍の sin, cos に一般化すると以下のようになる。
$$
\begin{aligned}
A_k &= \frac{2}{T} \int _0^T f(t) \cos k \omega_0 t dt \\\\
B_k &= \frac{2}{T} \int _0^T f(t) \sin k \omega_0 t dt \\\\
\end{aligned}
$$

cos の方に \\( k = 0 \\) を代入すると \\( \cos 0 = 1 \\) より都合よく
三角関数が消えて、

$$
\begin{aligned}
A_0 &= \frac{2}{T} \int _0^T f(t) dt \\\\
\end{aligned}
$$

となる。これは最初に求めた式の2倍になっているので、なんかいい感じに調整すると
式をきれいにできる。
しかし本来の意味から多少外れることになるかもしれない。

### 直交関数形

関数 \\( f(t) \\) の変数 t をある範囲で左から右へ少しずつ動かしながら、
その値 \\( f(t) \\) を順番に並べてベクトルを作ることを考える。
そのまま動かし方を細かくしていく (分割数を無限大に飛ばす) と、
関数は **無限次元のベクトル** とみなせる。

$$
\boldsymbol f = (
  f(a), f(a + \Delta t), f(a + 2\Delta t), \ \dots \ , f(b)
)
$$

さらに上記で行った **関数に同じ t を渡した関数を掛けて、積分する** という操作は
**ベクトルの同じ番号の値同士を掛けて、足し合わせる** という **内積** の操作に
似ていることが分かる。

$$
\begin{aligned}
\int_a^b f(t) g(t) dt
\end{aligned}
$$

高校数学のベクトルの内積は抽象化一般化された内積のうちの特殊ケースであって、
関数を掛けて積分したものも内積と呼ぶ。
(内積が満たすべき性質として内積の公理を考え、それをすべて満たすものになっている。)

後のことも考えると、まず複素ベクトルの内積は片方の複素共役を取ってから
実数の時と同じような計算を行うものと定義されることも知っておいた方がよい。
何でと言われればそちらの方が自然だから (内積の公理を満たすから) だし、
実数ベクトルの内積の左右を入れ替えられるのは、実数の複素共役はその数自身だからである。
複素ベクトルの内積では交換法則は一般に成り立たない
(代わりにエルミート性が成り立つ)。

$$
\boldsymbol a \cdot \boldsymbol b = \sum _{i=1}^n a_i \overline{b_i} \\\\
\boldsymbol a \cdot \boldsymbol b =
\overline{ \boldsymbol b \cdot \boldsymbol a }
$$

関数の内積も、複素関数まで通用するような形は片方の複素共役をとった形になる。

$$
\begin{aligned}
\int_0^T f(t) \overline{g(t)} dt
\end{aligned}
$$

二次元や三次元ベクトル同士の内積がゼロのとき、2つのベクトルは **直交する** と言った。
無限次元のベクトルととらえた関数同士の内積も、それがゼロとなるとき2つの関数は
**直交する** と言う。
無限次元ではもはや垂直とは何か全く分からないが、そういうものである。

抽象化された線形代数の世界で N 本の独立な (平行でない) ベクトルの線形和で表される
空間を N 次元空間と言った。
もし基底が (XY平面やXYZ空間のように) お互いに垂直で、かつ長さが 1 ならば、
扱いが非常に楽になる。
この条件を満たした基底の組を **正規直交基底** と呼ぶ。
正規は長さが1という意味、直交は他のすべてとの内積がゼロという意味である。

この条件の下では、ベクトルの X 成分を求めたいなら X 軸に垂線を下ろせばよいから、
(1, 0) との内積をとればよい。
この事実はフーリエ級数展開で係数を求める作業にそっくりである。

* 展開に使用している \\( sin k \omega_0 t , cos k \omega_0 t \\) は
  自身以外の全てとの内積、つまり関数同士を掛けて積分したもの、はゼロになる。
* 自分自身との内積、つまり2乗の積分は、ノルム (ベクトルの長さの一般化) の2乗であり、
  1になってくれると正規ベクトルとなり嬉しい。
  残念ながらそのままでは1にならないが、元の関数をいい感じの定数倍すれば
  簡単に1になるよう調整できる。
* 上記2つを満たすことにより、フーリエ級数展開に使う三角関数群は
  無限個の正規直交基底をなす。
* ある基底の方向の成分を求めるためには、その基底との内積を取るだけでよい。
  つまり (実数なら) その三角関数を掛けて積分するだけである。
  複素数なら片方の複素共役を取ってから掛ける。

## フーリエ級数展開 (複素数)

残念ながら、実数でのフーリエ級数展開は直感的な理解やイメージのしやすさに優れるが、
はっきり言って複素表現の方が便利 (デメリットは複素数への抵抗感くらいしかない) な
ため、実用では複素数による展開が用いられることがほとんどである。
なのでプログラミングや高速フーリエ変換など実践的なものをあたる前には
複素表現に慣れておかないと、実数だけでの理解だけでは非常に苦しい思いをする。

複素数のよく分からなさの感覚を捨て去り、慣れることが大切である。

まずはオイラーに感謝しつつ三角関数を消し去る。
三角関数は複素数の範囲では指数関数に **等しい** ため、
三角関数は全て消去して指数関数だけの式に変換することができる。
オイラーの公式はそのままでは指数関数を三角関数に変換する形になっているが、
まず角度 \\( \theta \\) のプラスマイナスを考える。
角度がマイナスになると cos そのままで sin は正負が入れ替わるので

$$
\begin{aligned}
e^{ i \theta } = \cos \theta + i \sin \theta \\\\
e^{ -i \theta } = \cos \theta - i \sin \theta \\\\
\end{aligned}
$$

これを片々足したり引いたりすることで
三角関数を指数関数に変換する式に変形することができる。

$$
\begin{aligned}
\cos \theta = \frac{1}{2} ( e^{ i \theta } + e^{ -i \theta } )
\end{aligned}
$$
