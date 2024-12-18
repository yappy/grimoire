# サバイバルツール類

## よく分からないファイルを調べる

ヘッダ情報をパースしてくれたり、テキストファイルならエンコーディングを調べてくれたり、
既に種類が分かっているファイル相手でもいい感じで要約された情報が得られる。

```sh
$ file rshanghai
rshanghai: ELF 64-bit LSB pie executable, ARM aarch64, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-aarch64.so.1, BuildID[sha1]=82b09bf2c510acc4e66f5a8bd9b65d0120968da6, for GNU/Linux 3.7.0, not stripped

$ file yappy_house_full.jpg
yappy_house_full.jpg: JPEG image data, JFIF standard 1.01, resolution (DPI), density 350x350, segment length 16, Exif Standard: [TIFF image data, big-endian, direntries=14], baseline, precision 8, 3118x3118, components 3

$ file src/tools.md
src/tools.md: Unicode text, UTF-8 text
```

## バイナリファイルのうち文字列として解釈可能な部分を表示

何らかの手掛かりを得たい場合や、
バイナリファイルに流出するとまずい情報が含まれていないか調べる時などに。

`-n <文字数>` で最低文字列長を指定できる。
デフォルトは 4 らしい。

```sh
$ strings rshanghai
/lib/ld-linux-aarch64.so.1
_ITM_deregisterTMCloneTable
__gmon_start__
_ITM_registerTMCloneTable
SSL_get_verify_result
SSL_shutdown
SSL_CTX_new
SSL_set_verify
SSL_get0_param
SSL_CTX_get_cert_store
...
```

## バイナリ表示

```sh
$ xxd rshanghai | head
00000000: 7f45 4c46 0201 0100 0000 0000 0000 0000  .ELF............
00000010: 0300 b700 0100 0000 c070 1a00 0000 0000  .........p......
00000020: 4000 0000 0000 0000 6831 0302 0000 0000  @.......h1......
00000030: 0000 0000 4000 3800 0a00 4000 2000 1f00  ....@.8...@. ...
00000040: 0600 0000 0400 0000 4000 0000 0000 0000  ........@.......
00000050: 4000 0000 0000 0000 4000 0000 0000 0000  @.......@.......
00000060: 3002 0000 0000 0000 3002 0000 0000 0000  0.......0.......
00000070: 0800 0000 0000 0000 0300 0000 0400 0000  ................
00000080: 7002 0000 0000 0000 7002 0000 0000 0000  p.......p.......
00000090: 7002 0000 0000 0000 1b00 0000 0000 0000  p...............

$ xxd -g 1 rshanghai | head
00000000: 7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00  .ELF............
00000010: 03 00 b7 00 01 00 00 00 c0 70 1a 00 00 00 00 00  .........p......
00000020: 40 00 00 00 00 00 00 00 68 31 03 02 00 00 00 00  @.......h1......
00000030: 00 00 00 00 40 00 38 00 0a 00 40 00 20 00 1f 00  ....@.8...@. ...
00000040: 06 00 00 00 04 00 00 00 40 00 00 00 00 00 00 00  ........@.......
00000050: 40 00 00 00 00 00 00 00 40 00 00 00 00 00 00 00  @.......@.......
00000060: 30 02 00 00 00 00 00 00 30 02 00 00 00 00 00 00  0.......0.......
00000070: 08 00 00 00 00 00 00 00 03 00 00 00 04 00 00 00  ................
00000080: 70 02 00 00 00 00 00 00 70 02 00 00 00 00 00 00  p.......p.......
00000090: 70 02 00 00 00 00 00 00 1b 00 00 00 00 00 00 00  p...............

# エンディアンのせいで変。。
$ hexdump rshanghai | head
0000000 457f 464c 0102 0001 0000 0000 0000 0000
0000010 0003 00b7 0001 0000 70c0 001a 0000 0000
0000020 0040 0000 0000 0000 3168 0203 0000 0000
0000030 0000 0000 0040 0038 000a 0040 0020 001f
0000040 0006 0000 0004 0000 0040 0000 0000 0000
0000050 0040 0000 0000 0000 0040 0000 0000 0000
0000060 0230 0000 0000 0000 0230 0000 0000 0000
0000070 0008 0000 0000 0000 0003 0000 0004 0000
0000080 0270 0000 0000 0000 0270 0000 0000 0000
0000090 0270 0000 0000 0000 001b 0000 0000 0000

# -C でいい感じになる
$ hexdump -C rshanghai | head
00000000  7f 45 4c 46 02 01 01 00  00 00 00 00 00 00 00 00  |.ELF............|
00000010  03 00 b7 00 01 00 00 00  c0 70 1a 00 00 00 00 00  |.........p......|
00000020  40 00 00 00 00 00 00 00  68 31 03 02 00 00 00 00  |@.......h1......|
00000030  00 00 00 00 40 00 38 00  0a 00 40 00 20 00 1f 00  |....@.8...@. ...|
00000040  06 00 00 00 04 00 00 00  40 00 00 00 00 00 00 00  |........@.......|
00000050  40 00 00 00 00 00 00 00  40 00 00 00 00 00 00 00  |@.......@.......|
00000060  30 02 00 00 00 00 00 00  30 02 00 00 00 00 00 00  |0.......0.......|
00000070  08 00 00 00 00 00 00 00  03 00 00 00 04 00 00 00  |................|
00000080  70 02 00 00 00 00 00 00  70 02 00 00 00 00 00 00  |p.......p.......|
00000090  70 02 00 00 00 00 00 00  1b 00 00 00 00 00 00 00  |p...............|

# octal dump なのでデフォルトは8進数になる
$ od rshanghai | head
0000000 042577 043114 000402 000001 000000 000000 000000 000000
0000020 000003 000267 000001 000000 070300 000032 000000 000000
0000040 000100 000000 000000 000000 030550 001003 000000 000000
0000060 000000 000000 000100 000070 000012 000100 000040 000037
0000100 000006 000000 000004 000000 000100 000000 000000 000000
0000120 000100 000000 000000 000000 000100 000000 000000 000000
0000140 001060 000000 000000 000000 001060 000000 000000 000000
0000160 000010 000000 000000 000000 000003 000000 000004 000000
0000200 001160 000000 000000 000000 001160 000000 000000 000000
0000220 001160 000000 000000 000000 000033 000000 000000 000000

# 16進デフォルトは 16 bit ごとの上にエンディアンのせいで変。。
$ od -x rshanghai | head
0000000 457f 464c 0102 0001 0000 0000 0000 0000
0000020 0003 00b7 0001 0000 70c0 001a 0000 0000
0000040 0040 0000 0000 0000 3168 0203 0000 0000
0000060 0000 0000 0040 0038 000a 0040 0020 001f
0000100 0006 0000 0004 0000 0040 0000 0000 0000
0000120 0040 0000 0000 0000 0040 0000 0000 0000
0000140 0230 0000 0000 0000 0230 0000 0000 0000
0000160 0008 0000 0000 0000 0003 0000 0004 0000
0000200 0270 0000 0000 0000 0270 0000 0000 0000
0000220 0270 0000 0000 0000 001b 0000 0000 0000

$ od -t x1 rshanghai | head
0000000 7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00
0000020 03 00 b7 00 01 00 00 00 c0 70 1a 00 00 00 00 00
0000040 40 00 00 00 00 00 00 00 68 31 03 02 00 00 00 00
0000060 00 00 00 00 40 00 38 00 0a 00 40 00 20 00 1f 00
0000100 06 00 00 00 04 00 00 00 40 00 00 00 00 00 00 00
0000120 40 00 00 00 00 00 00 00 40 00 00 00 00 00 00 00
0000140 30 02 00 00 00 00 00 00 30 02 00 00 00 00 00 00
0000160 08 00 00 00 00 00 00 00 03 00 00 00 04 00 00 00
0000200 70 02 00 00 00 00 00 00 70 02 00 00 00 00 00 00
0000220 70 02 00 00 00 00 00 00 1b 00 00 00 00 00 00 00
```

コマンドラインパラメータを覚えられないので、デフォルトで見やすい `xxd` を
第一選択肢に覚えておくのがいい気がする。
コマンド名の覚えやすさで行くなら `hexdump -C`。

なんでいろいろあるの？

* xxd は vim についてくるツールらしい。
* hexdump は BSD 由来で Linux にも入っている系らしい。
* od は由緒正しく POSIX でも規定されているコマンドらしい。
  * 由緒正しすぎて 8 進ダンプは現代ではほぼ使われないのではないかとも思う。

## バイナリファイルを編集する

`xxd` が vim についてくるというのはこうやって使えということらしい。
~~やったことがない。~~
`xxd -r` でテキストダンプからバイナリに逆変換できる。

```sh
$ vi -b file.bin
:%!xxd
:%!xxd -r
:wq
```

## バイナリファイルを C ヘッダに変換する

こういうのでいいんだよこういうので。
圧倒的なポータビリティを誇る。

```sh
$ xxd -i rshanghai | head
unsigned char rshanghai[] = {
  0x7f, 0x45, 0x4c, 0x46, 0x02, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00,
  0x00, 0x00, 0x00, 0x00, 0x03, 0x00, 0xb7, 0x00, 0x01, 0x00, 0x00, 0x00,
  0xc0, 0x70, 0x1a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00,
  0x00, 0x00, 0x00, 0x00, 0x68, 0x31, 0x03, 0x02, 0x00, 0x00, 0x00, 0x00,
  0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x38, 0x00, 0x0a, 0x00, 0x40, 0x00,
  0x20, 0x00, 0x1f, 0x00, 0x06, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00,
  0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00,
  0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
  0x30, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x30, 0x02, 0x00, 0x00,

# -C で変数名を大文字に
# -name で変数名を変更
$ xxd -i -C -name myname rshanghai | head
unsigned char MYNAME[] = {
  0x7f, 0x45, 0x4c, 0x46, 0x02, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00,
  0x00, 0x00, 0x00, 0x00, 0x03, 0x00, 0xb7, 0x00, 0x01, 0x00, 0x00, 0x00,
  0xc0, 0x70, 0x1a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00,
  0x00, 0x00, 0x00, 0x00, 0x68, 0x31, 0x03, 0x02, 0x00, 0x00, 0x00, 0x00,
  0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x38, 0x00, 0x0a, 0x00, 0x40, 0x00,
  0x20, 0x00, 0x1f, 0x00, 0x06, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00,
  0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00,
  0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
  0x30, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x30, 0x02, 0x00, 0x00,
```

## バイナリファイルをオブジェクトファイルに変換してリンクする

objcopy はオブジェクトファイルのコピーを行うが、ただのフルコピーなら `cp` コマンドで
いい訳で、実質的にフォーマット変換コマンドである。
`-I` や `-O` で入出力フォーマットを指定できるが、ここに `binary` が指定可能である。

```sh
# -B を指定しないとリンカエラーになる気がする
$ objcopy -I binary -O elf64-little yappy_house.jpg  yappy_house.o
```

デフォルトだと `.data` (読み書き可能グローバル変数領域) セクションに
配置されてしまうので、気になるなら `--rename-section` を使う。
man に例があるので
`--rename-section .data=.rodata,alloc,load,readonly,data,contents`
をコピーして使えばよさそう。

```sh
$ man objcopy
--rename-section oldname=newname[,flags]
    Rename a section from oldname to newname, optionally changing the section's flags to flags in the process.
    This has the advantage over using a linker script to perform the rename in that the output stays as an
    object file and does not become a linked executable.  This option accepts the same set of flags as the
    --sect-section-flags option.

    This option is particularly helpful when the input format is binary, since this will always create a
    section called .data.  If for example, you wanted instead to create a section called .rodata containing
    binary data you could use the following command line to achieve it:

              objcopy -I binary -O <output_format> -B <architecture> \
              --rename-section .data=.rodata,alloc,load,readonly,data,contents \
              <input_binary_file> <output_object_file>
```

オブジェクトファイルには以下のようなシンボルが定義される。

```sh
$ nm yappy_house.o
00000000000218b7 D _binary_yappy_house_jpg_end
00000000000218b7 A _binary_yappy_house_jpg_size
0000000000000000 D _binary_yappy_house_jpg_start

# リンク後
$ nm a.out | grep _binary
00000000000418ef D _binary_yappy_house_jpg_end
00000000000218b7 A _binary_yappy_house_jpg_size
0000000000020038 D _binary_yappy_house_jpg_start
```

size は分かりづらいが、absolute シンボルとして定義され、リンクしても値が変わらない。
シンボルアドレスがファイルサイズになっている。
なので奇数サイズのファイルの場合、奇数アドレスのシンボルができる。気持ち悪い。
1 byte 型のポインタとして `end - start` を計算すれば出てくるので、
size は使わなくてもいいかもしれない…。

C 以外で用意したシンボルを C から参照する際は型で混乱しやすいので注意。
シンボル情報のレベルでは型情報が消えているので無難な 1 byte 型にしてやるとよい。

```C
// unsigned char _binary_yappy_house_jpg_start[SIZE] = {...};
// を定義すると
// "_binary_yappy_house_jpg_start"
// という配列の先頭アドレスを指すシンボルが生成されると考える
extern const unsigned char _binary_yappy_house_jpg_start[];
extern const unsigned char _binary_yappy_house_jpg_end[];
```

## ELF ファイル情報

ELF (Exectable and Linking Format) は名前の通り、実行可能形式および
その前のリンク中のデータのフォーマット。
EXE (PE) と違ってまだ実行可能でないオブジェクトファイルもこの形式で出力される。

実は file コマンドでも結構それなりに表示される。

```sh
$ file /usr/bin/ls
/usr/bin/ls: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV),
dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]
=15dfff3239aa7c3b16a71e6b2e3b6e4009dab998, for GNU/Linux 3.2.0, stripped
```

`readelf -h` でヘッダをパースしてくれる。

```sh
$ readelf -h /usr/bin/ls
ELF Header:
  Magic:   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF64
  Data:                              2 s complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              DYN (Position-Independent Executable file)
  Machine:                           Advanced Micro Devices X86-64
  Version:                           0x1
  Entry point address:               0x61d0
  Start of program headers:          64 (bytes into file)
  Start of section headers:          149360 (bytes into file)
  Flags:                             0x0
  Size of this header:               64 (bytes)
  Size of program headers:           56 (bytes)
  Number of program headers:         13
  Size of section headers:           64 (bytes)
  Number of section headers:         31
  Section header string table index: 30
```

ELF ヘッダに続くプログラムヘッダは `readelf -l` で。
ファイル中の何バイト目から何バイトをメモリの何バイト目にロードすれば
よいかが書かれている。

```sh
$ readelf -l /usr/bin/ls

Elf file type is DYN (Position-Independent Executable file)
Entry point 0x61d0
There are 13 program headers, starting at offset 64

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  PHDR           0x0000000000000040 0x0000000000000040 0x0000000000000040
                 0x00000000000002d8 0x00000000000002d8  R      0x8
  INTERP         0x0000000000000318 0x0000000000000318 0x0000000000000318
                 0x000000000000001c 0x000000000000001c  R      0x1
      [Requesting program interpreter: /lib64/ld-linux-x86-64.so.2]
  LOAD           0x0000000000000000 0x0000000000000000 0x0000000000000000
                 0x00000000000036c0 0x00000000000036c0  R      0x1000
  LOAD           0x0000000000004000 0x0000000000004000 0x0000000000004000
                 0x0000000000015759 0x0000000000015759  R E    0x1000
  LOAD           0x000000000001a000 0x000000000001a000 0x000000000001a000
                 0x0000000000008ed0 0x0000000000008ed0  R      0x1000
  LOAD           0x00000000000232b0 0x00000000000232b0 0x00000000000232b0
                 0x0000000000001310 0x00000000000025f8  RW     0x1000
  DYNAMIC        0x0000000000023d98 0x0000000000023d98 0x0000000000023d98
                 0x00000000000001f0 0x00000000000001f0  RW     0x8
  NOTE           0x0000000000000338 0x0000000000000338 0x0000000000000338
                 0x0000000000000020 0x0000000000000020  R      0x8
  NOTE           0x0000000000000358 0x0000000000000358 0x0000000000000358
                 0x0000000000000044 0x0000000000000044  R      0x4
  GNU_PROPERTY   0x0000000000000338 0x0000000000000338 0x0000000000000338
                 0x0000000000000020 0x0000000000000020  R      0x8
  GNU_EH_FRAME   0x000000000001ef7c 0x000000000001ef7c 0x000000000001ef7c
                 0x00000000000009fc 0x00000000000009fc  R      0x4
  GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
                 0x0000000000000000 0x0000000000000000  RW     0x10
  GNU_RELRO      0x00000000000232b0 0x00000000000232b0 0x00000000000232b0
                 0x0000000000000d50 0x0000000000000d50  R      0x1
```

セクションヘッダは `readelf -S`。
.text や .data、.bss などのセクション (に加えて意味の分からないものも大量に)
が見える。

```sh
$ readelf -S /usr/bin/ls
There are 31 section headers, starting at offset 0x24770:

Section Headers:
  [Nr] Name              Type             Address           Offset
       Size              EntSize          Flags  Link  Info  Align
  [ 0]                   NULL             0000000000000000  00000000
       0000000000000000  0000000000000000           0     0     0
  [ 1] .interp           PROGBITS         0000000000000318  00000318
       000000000000001c  0000000000000000   A       0     0     1
  [ 2] .note.gnu.pr[...] NOTE             0000000000000338  00000338
       0000000000000020  0000000000000000   A       0     0     8
  [ 3] .note.gnu.bu[...] NOTE             0000000000000358  00000358
       0000000000000024  0000000000000000   A       0     0     4
  [ 4] .note.ABI-tag     NOTE             000000000000037c  0000037c
       0000000000000020  0000000000000000   A       0     0     4
  [ 5] .gnu.hash         GNU_HASH         00000000000003a0  000003a0
       00000000000000b8  0000000000000000   A       6     0     8
  [ 6] .dynsym           DYNSYM           0000000000000458  00000458
       0000000000000be8  0000000000000018   A       7     1     8
  [ 7] .dynstr           STRTAB           0000000000001040  00001040
       00000000000005d9  0000000000000000   A       0     0     1
  [ 8] .gnu.version      VERSYM           000000000000161a  0000161a
       00000000000000fe  0000000000000002   A       6     0     2
  [ 9] .gnu.version_r    VERNEED          0000000000001718  00001718
       00000000000000d0  0000000000000000   A       7     2     8
  [10] .rela.dyn         RELA             00000000000017e8  000017e8
       0000000000001560  0000000000000018   A       6     0     8
  [11] .rela.plt         RELA             0000000000002d48  00002d48
       0000000000000978  0000000000000018  AI       6    25     8
  [12] .init             PROGBITS         0000000000004000  00004000
       0000000000000017  0000000000000000  AX       0     0     4
  [13] .plt              PROGBITS         0000000000004020  00004020
       0000000000000660  0000000000000010  AX       0     0     16
  [14] .plt.got          PROGBITS         0000000000004680  00004680
       0000000000000030  0000000000000008  AX       0     0     8
  [15] .text             PROGBITS         00000000000046b0  000046b0
       000000000001509e  0000000000000000  AX       0     0     16
  [16] .fini             PROGBITS         0000000000019750  00019750
       0000000000000009  0000000000000000  AX       0     0     4
  [17] .rodata           PROGBITS         000000000001a000  0001a000
       0000000000004f7a  0000000000000000   A       0     0     32
  [18] .eh_frame_hdr     PROGBITS         000000000001ef7c  0001ef7c
       00000000000009fc  0000000000000000   A       0     0     4
  [19] .eh_frame         PROGBITS         000000000001f978  0001f978
       0000000000003558  0000000000000000   A       0     0     8
  [20] .init_array       INIT_ARRAY       00000000000232b0  000232b0
       0000000000000008  0000000000000008  WA       0     0     8
  [21] .fini_array       FINI_ARRAY       00000000000232b8  000232b8
       0000000000000008  0000000000000008  WA       0     0     8
  [22] .data.rel.ro      PROGBITS         00000000000232c0  000232c0
       0000000000000ad8  0000000000000000  WA       0     0     32
  [23] .dynamic          DYNAMIC          0000000000023d98  00023d98
       00000000000001f0  0000000000000010  WA       7     0     8
  [24] .got              PROGBITS         0000000000023f88  00023f88
       0000000000000050  0000000000000008  WA       0     0     8
  [25] .got.plt          PROGBITS         0000000000023fe8  00023fe8
       0000000000000340  0000000000000008  WA       0     0     8
  [26] .data             PROGBITS         0000000000024340  00024340
       0000000000000280  0000000000000000  WA       0     0     32
  [27] .bss              NOBITS           00000000000245c0  000245c0
       00000000000012e8  0000000000000000  WA       0     0     32
  [28] .gnu_debugaltlink PROGBITS         0000000000000000  000245c0
       0000000000000049  0000000000000000           0     0     1
  [29] .gnu_debuglink    PROGBITS         0000000000000000  0002460c
       0000000000000034  0000000000000000           0     0     4
  [30] .shstrtab         STRTAB           0000000000000000  00024640
       000000000000012f  0000000000000000           0     0     1
```

### シンボル一覧

`nm` が便利。
strip されていると消えて見えない。。

```sh
$ nm /usr/bin/ls
nm: /usr/bin/ls: no symbols
```

シンボルタイプは1文字で表されるが、覚えられない。
`U` (おそらく undefined) が未定義シンボル (他のファイルにあるシンボルへの参照) で、
リンク時に他のオブジェクトファイルから提供される必要がある。

なお、libc (C 標準ライブラリ) などは基本的に動的リンクが選択されるので、
実行可能形式までリンクされた後でもまだ未解決シンボルは残る。
動的リンク周りは理屈自体はそこまで難しくはない
(リンカの行っている作業を一部実行時にまで遅延させているだけ) ものの、
実際にその動作を追おうとすると、全人類がお世話になっている割には
書いた人しか分からない魔境と化しているため踏み入るには注意が必要。

```sh
$ nm rshanghai | grep U
                 U abort@GLIBC_2.2.5
                 U accept4@GLIBC_2.10
                 U bcmp@GLIBC_2.2.5
                 U bind@GLIBC_2.2.5
                 U BIO_clear_flags@OPENSSL_3.0.0
                 U BIO_get_data@OPENSSL_3.0.0
                 U BIO_meth_free@OPENSSL_3.0.0
                 U BIO_meth_new@OPENSSL_3.0.0
                 U BIO_meth_set_create@OPENSSL_3.0.0
                 U BIO_meth_set_ctrl@OPENSSL_3.0.0
                 U BIO_meth_set_destroy@OPENSSL_3.0.0
                 U BIO_meth_set_puts@OPENSSL_3.0.0
                 U BIO_meth_set_read@OPENSSL_3.0.0
                 U BIO_meth_set_write@OPENSSL_3.0.0
                 U BIO_new@OPENSSL_3.0.0
                 U BIO_set_data@OPENSSL_3.0.0
                 U BIO_set_flags@OPENSSL_3.0.0
                 U BIO_set_init@OPENSSL_3.0.0
                 U calloc@GLIBC_2.2.5
                 U ceilf@GLIBC_2.2.5
                 U ceil@GLIBC_2.2.5
                 U chdir@GLIBC_2.2.5
                 U chown@GLIBC_2.2.5
                 U chroot@GLIBC_2.2.5
...
```

シンボルはアドレスに振られたラベルであり、型情報は消えている。
なので変数や関数の型 (シグネチャ) と名前を書いたヘッダファイルは複数ソース間で
同じものを使わないとリンクまで成功してしまい、実行時に壊れる。
また、アドレスはリンクして実行可能ファイルになるまでは仮の値
(ゼロスタート) になっている。
