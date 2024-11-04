# マルチコアと同期

3行まとめ

* ロックを使え。

## マルチスレッド

シングルコアでは物理的に同時に動くのは1つのプログラムである。
しかし、その時代から OS によるマルチタスキング・マルチスレッドの概念はあった。
OS が適当なタイミング (特別な理由がなければタイマ割り込み) を契機に実行中の
スレッドから実行権を剥奪 (プリエンプト) し、別のスレッドに切り替える。

※それより前は OS ではなくアプリケーションが自ら CPU を手放す協調的スケジューリングも
あったが、アプリがバグると CPU を放さなくなってしまうので、現代の OS ではシステムが
勝手にタスクを切り替えるプリエンプティブスケジューリングが採用されることが多い。
ただし OS のスレッドの上でユーザランドでタスクを切り替えるグリーンスレッドだとか
最近流行りの async-await 系の話では協調的スケジューリングも現役と言える。

現代ではシングルコア性能の向上に限界を迎え、CPU のマルチコア化が進んでいる。
ハードウェア設計の方の話で N コア M スレッドのように言われると
コアという用語が何を指すのか分かりづらいため、ソフトウェア/OS の世界では
「CPU0, CPU1, ...」「ハードウェアスレッド」のような呼び方をすることも多い。
しかし口語では簡単にコアと言ってしまうことも多く、要はプログラムを実行できるユニット
1つ分のことである。

マルチコア用 OS では、スレッドを同時にコア数分まで同時に物理的に実行することができる。
しかしそれより多くは不可能なので、そこから先はシングルスレッドと同様の方法で
スレッドの切り替えを行うことになる。

マルチコア環境では複数のプログラムを同時に実行するとマルチコアの恩恵を受けやすいが、
1つのプログラムに関してはマルチスレッドプログラミングを意識して行わないと
マルチコアの恩恵をほとんど受けられない。

PC の CPU 使用率の (できればコアごとの) モニタを見てみると分かるが、
現代の PC においては、一部の限られた作業以外では CPU コアを持て余しているのが
普通である。
シングルコアの時代では割と頻繁に CPU 使用率が 100% に「張り付いていた」が、
現代では全コア 100% となることは一部のタスクを除いてほとんどない。
したがって CPU が実行速度のボトルネックになることは少なく、
高級なコア数の多い CPU を選ぶ価値は低い。

ただしマルチコア CPU の並列性を大いに生かした作業を行う場合は例外であり、
低性能なコア数の少ない CPU を強制的に使用させるような行為は基本的人権の侵害となる。

* プログラムの並列ビルド
* 将棋の手読み
* AI のための行列演算は GPU を用いた方がよい。

## 主流のハードウェア構成

主流でなければ色々な構成が考えられるという前提の上で、PC やスマホ等で主流の構成は

* N コア M スレッド
  * 例: 8 コア 16 スレッド
  * プログラムの実行主体が 1 コアあたり (M/N) 本ある、という意味。
  * ソフトウェア視点、OS を書くくらいの視点以上からは単に M コアであるとみなして
    問題ない。
  * 例: 8 コア 16 スレッド => OS からは CPU0..15 の 16 コアあるように見えるはず
* L1 キャッシュ (コアごと)
* L2 キャッシュ (共通)
* L3 キャッシュ (共通)
* メモリ
  * CPU の速度向上に置いて行かれてとんでもなく遅い(だからキャッシュがある)。

## スレッドライブラリ

### pthread

POSIX 標準の C API。

```C
#include <stdio.h>
#include <pthread.h>

void *print_hello(void *arg) {
    printf("Hello, World!\n");
    return NULL;
}

int main() {
    pthread_t thread1;

    if (pthread_create(&thread1, NULL, print_hello, NULL) != 0) {
        fprintf(stderr, "Error creating thread\n");
        return 1;
    }

    if (pthread_join(thread1, NULL) != 0) {
        fprintf(stderr, "Error joining thread\n");
        return 1;
    }

    return 0;
}
```

### std::thread

余計な記述が少なく結構使いやすい。

```C++
#include <cassert>
#include <thread>

int main()
{
  int x = 0, y = 0;

  std::thread t([&]{ ++x; });
  --y;
  t.join();

  assert(x == 1 && y == -1);
  return 0;
}
```

### Rust

スレッドセーフでないコードは基本的にコンパイルが通らない。

```rust
use std::thread;
use std::time::Duration;

fn main() {
    let handle = thread::spawn(|| {
        for i in 1..10 {
            println!("hi number {} from the spawned thread!", i);
            thread::sleep(Duration::from_millis(1));
        }
    });

    for i in 1..5 {
        println!("hi number {} from the main thread!", i);
        thread::sleep(Duration::from_millis(1));
    }

    handle.join().unwrap();
}
```

## 競合状態 (race condition)

スレッド間で通信をするためには、メモリ空間を共有していることを考えると、
共有メモリを読み書きするのが手軽である。

以下は shared_mem を 256 スレッドから 1000000 回インクリメントするが、
256000000 にはならない (ことがある)。

```C
#include <stdio.h>
#include <pthread.h>

void *proc(void *arg) {
  int *shared_mem = (int *)arg;
  for (int i = 0; i < 1000000; i++) {
    (*shared_mem)++;
  }

  return NULL;
}

int main() {
  pthread_t th[256];
  int shared_mem = 0;

  for (int i = 0; i < 256; i++) {
    if (pthread_create(&th[i], NULL, proc, &shared_mem) != 0) {
      fprintf(stderr, "Error creating thread\n");
      return 1;
    }
  }
  for (int i = 0; i < 256; i++) {
    if (pthread_join(th[i], NULL) != 0) {
      fprintf(stderr, "Error joining thread\n");
      return 1;
    }
  }

  printf("shared_mem = %d\n", shared_mem);

  return 0;
}
```

このように何の工夫もなく複数のスレッドから共通のメモリを読み書きすると、色々と壊れる。
しかも確率的にごく稀に壊れることもある。
これを競合状態 (race condition)、スレッドセーフでない等という。

スレッドセーフでないコードが具体的にどうなるかは非常に説明が難しい。
当然ハードウェア実装にもよる。

昔ながらの教科書では以下のように説明されることが多いし、一旦はこれで納得すること。
でもこういうケースなら大丈夫じゃないの？と思ったりするが、全然大丈夫じゃないので
その思考に至るレベルでは必ずロックを取ること。

1. スレッドAがメモリから値 0 を CPU 内に読む
1. スレッドBがメモリから値 0 を CPU 内に読む
1. スレッドAが CPU 内でインクリメントを行い、値 1 を CPU 内に用意する
1. スレッドAがメモリへ値 1 を書き込む
1. スレッドBが CPU 内でインクリメントを行い、値 1 を CPU 内に用意する
1. スレッドBがメモリへ値 1 を書き込む

* まず、コンパイラの最適化がかかる。コンパイラ最適化はシングルスレッドでの実行結果が
  変わらないことしか保証しない。
  * `volatile int *` とすると、1000000 回メモリに書き込む機械語が生成されることは
    保証される。ただし volatile 単独ではスレッドセーフにはならない。
    巷にはインチキコードが溢れているので注意。
* 高機能なプロセッサでは Out-of-Order 実行によって CPU の内部で機械語の実行順序を
  並べ替えられる。こちらもシングルスレッドでの実行結果が変わらないことしか保証しない。
  * こんなとんでもないことをわざわざする理由については、CPU 設計のパイプラインと
    命令間依存性、ハザードの話を参照。
    ジムケラーを恨め。
* パイプライン実行によって1命令を何クロックもかけて、他の命令と同時並列で実行する。
* そのような CPU コアが複数あり、それぞれが同一クロックで独立して動いている。
* この世の終わり。

Note: 読み出しのみならセーフ。
メモリに置いた定数を複数スレッドから共有するのは問題ない。

## ロック (ミューテックス)

## 注意: volatile は罠

CON02-C. volatile を同期用プリミティブとして使用しない

<https://www.jpcert.or.jp/sc-rules/c-con02-c.html>

volatile は主にメモリマップされたハードウェアレジスタを読み書きすることを
意図したもので、単体でスレッドセーフにする効果はない。
メモリアクセスをコンパイラ最適化で省略しないというのは共有メモリで通信する以上
必須ではあるのだが、それだけでは全然足りないためである。
生成される機械語が変わるので、レースバグの再現率を変える実験くらいにしか使えない。
レースバグは絶対に直らない。

* volatile オブジェクトへの読み書きのメモリアクセスは省略されない。
  * Memory Mapped I/O (メモリアクセス命令で特定レンジへのアクセスが
    メインメモリではなく他のハードウェアデバイスへ飛んで制御できる方法。)
    がうまくいくようになる。
  * 2回異なるデータを同じ場所に書き込んだ時、1回目は無駄だからといって
    省略してはならない。それは通常のメモリの場合であって、それ以外の
    ハードウェアデバイスへの書き込みには意味がある可能性がある。
    1を書き込んだタイミングで処理開始、とか。
  * 複数回の同一アドレスからの読み出しも省略してはならない。
    CPU 外のハードウェアは CPU とは独立して動作しており、
    読み出される値は変更される可能性がある
    (volatile = 揮発性 = 何もしなくても状態が勝手に変わる)。
* メモリを使わずレジスタだけで済ませるという最適化も無効。

難しい話が分からない場合は、書き込みを伴う共有変数には必ずロックを使うこと。
ロックに代表される同期プリミティブと呼ばれるオブジェクトは、
難しい話を全てクリアしてある。

## アトミック命令 (ここから上級者向け)

古い OS の教科書にはピーターソンのアルゴリズムやデッカーのアルゴリズムなど、
ハードウェアサポートなしで同期を取ろうとする天才プログラムが載っていたりするが、
Out-of-Order + マルチコアのような現代の世紀末環境では全く通用しないし、
専用の命令をハードウェアに用意してもらった方が効率的で使い方も簡単である。

アトミック性 (atomicity) とは、不可分

## メモリオーダリング・メモリバリア・フェンス

## メモリモデル・一貫性モデル

## ロックの作り方

### 割り込み禁止 (シングルコア専用・カーネルモード専用)

シングルコア限定で絶対にレースしない必殺技があって、それが割り込み禁止である。

CPU の割り込み機能はオフにできるため、そうしている間は突然実行コンテキストが切り替わる
ことが絶対にない (NMI (Non-Maskable Interrupt) は除く)。
タイマ割り込みも無効になる。

ただし当然、早急な処理を求められる外部ハードウェアへの応答が遅れるため、
長時間のロックはご法度である。
また当然、カーネルモード (OS の中) でしか変更できない。

割り込みハンドラとの間でも同期が取れることになるが、
割り込みハンドラと変数を共有していない場合はプリエンプト禁止で十分かもしれない。
プリエンプト禁止は CPU のハードウェア設定ではなく、OS 上でのソフトウェア的な
制御になる。

### スピンロック (マルチコア向け・カーネルモード向け)

アトミック命令を使って初めに作ることになる、最も単純なロックである。
シングルコアではビジーウェイト (メモリの値が変わるまで読み続ける) は
他のスレッドにスイッチしてメモリが書き換えられるまで無駄に CPU 時間を消費するため
行儀の悪いスタイルと言われるが、マルチコアではビジーウェイト中も他のコアが動けるため、
ロック時間が十分短いならばコンテキストスイッチのコストがかからずむしろ
性能のよいロックとなる。
また、割り込みハンドラ同士または割り込みハンドラとスレッドコンテキストとの間の
ロックとして使用可能である。

データ構造としては、ロック本体はメモリ上に 1 word 程度の整数を用意するだけで
ロック1つを実現できる。

xv6 (RISC-V) での実装

```C
// Mutual exclusion lock.
struct spinlock {
  uint locked;       // Is the lock held?

  // For debugging:
  char *name;        // Name of lock.
  struct cpu *cpu;   // The cpu holding the lock.
};
```

まず、スピンロックを取得した状態で、解放前に自身のコアで割り込みが入り、
その割り込みハンドラでそのロックを取得しようとした場合、デッドロックして
コアが割り込みハンドラ内で固まってしまう。
そのため初めにローカルコア割り込みを OFF にしている。
割り込みハンドラからロックしないならば、これは不要とも言える。
ただしタイマ割り込みからのプリエンプトは禁止すべきだろう。
オープンソースの OS の実装を見て回るのもよい。

次の `__sync_lock_test_and_set()` がアトミック命令で、ロックの本体である。
アセンブラで直接書くか、このように gcc 拡張を使って多少ハードウェア非依存っぽく
書くこともできる。
このようなコンパイラ拡張は、コンパイラへの並べ替え禁止効果を含んでいて便利である。
自力でやるときは `asm volatile` とか使う。多分。

`test_and_set` は名前と違って atomic_swap に近いらしい。
「メモリを読んで返す」のと「メモリに第二引数 (1) を書き込む」を同時に行い、
その途中状態を他のコアから観測されないようにする。
具体的にはメモリバスロックを行い、自分以外のコアのメモリアクセスを禁止するとか。多分。

コードとしてはメモリ内容と 1 をアトミックに交換し、0 が取得された場合は
ロックが取れた (ロック変数を0から1に変更した) とみなし、
1 が取得された場合はロックが取れなかった (ロック変数は1から1のまま) とみなす、
というだけのことである。
ロックのキモはたったこれだけではある。
両方のスレッドからアクセス可能な 1 word 程度のメモリがあれば実現できる。
ただし、他がやばい。

```C
// Acquire the lock.
// Loops (spins) until the lock is acquired.
void
acquire(struct spinlock *lk)
{
  push_off(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");

  // On RISC-V, sync_lock_test_and_set turns into an atomic swap:
  //   a5 = 1
  //   s1 = &lk->locked
  //   amoswap.w.aq a5, a5, (s1)
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen strictly after the lock is acquired.
  // On RISC-V, this emits a fence instruction.
  __sync_synchronize();

  // Record info about lock acquisition for holding() and debugging.
  lk->cpu = mycpu();
}

// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");

  lk->cpu = 0;

  // Tell the C compiler and the CPU to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other CPUs before the lock is released,
  // and that loads in the critical section occur strictly before
  // the lock is released.
  // On RISC-V, this emits a fence instruction.
  __sync_synchronize();

  // Release the lock, equivalent to lk->locked = 0.
  // This code doesn't use a C assignment, since the C standard
  // implies that an assignment might be implemented with
  // multiple store instructions.
  // On RISC-V, sync_lock_release turns into an atomic swap:
  //   s1 = &lk->locked
  //   amoswap.w zero, zero, (s1)
  __sync_lock_release(&lk->locked);

  pop_off();
}
```

ロックを使わずアトミック命令でスレッドセーフに書く (ロックを作る時など)
ための条件は以下の通り。

* 通常のメモリロードストア命令ではなくアトミック命令を使い、
  途中の状態を他のコアから観測されないようにする。
* コンパイラ最適化を無効にし、特定のラインをまたいだ命令の並べ替えを防止する。
* メモリバリア命令を置き、それをまたいだ CPU 内での命令の並べ替えを防止する。

volatile の付与だけでは全然足りないことが分かる。

コンパイラによるコンパイル時の並べ替えと CPU による実行時の並べ替えは、
いつやるかが違うだけで概念としては同じものが使える。
メモリの読み書きの (物理的な) 順番の制御をメモリオーダリングと呼び、
手動でそれを防ぐ手段をメモリバリアと呼ぶ。

ちなみに x86 はメモリオーダリングに関してはかなり「堅い」方で、ARM はユルユルである。
Google が Android のために JVM を x86 から ARM に持っていったら
怪奇現象にしか見えないメモリオーダリングのバグに苦労したらしい…。

### スリープロック (普通のロック)

## ロックフリーアルゴリズム (初心者お断り)
