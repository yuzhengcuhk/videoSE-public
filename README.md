# videoSE-public
**[MMSys22] Encrypted Video Search: Scalable, Modular, and Content-similar**
 
We initiate the study of scalable encrypted video search in which a client can search videos similar to an image query. Our modular framework abstracts intrinsic attributes of videos in semantics and visuals to capture their contents. We advocate two-step searches by incorporating lightweight searchable encryption techniques for pre-screening and an interactive approach for fine-grained search.

The details of this project are presented in the following paper:

[Encrypted Video Search: Scalable, Modular, and Content-similar](https://dl.acm.org/doi/pdf/10.1145/3524273.3528190) <br>
**[Yu Zheng](https://github.com/yuzhengcuhk), [Heng Tian](https://github.com/tanhunggg), [Minxin Du](https://duminxin.github.io), [Chong Fu](https://scholar.google.com/citations?user=xq76xEMAAAAJ&hl=zh-CN)** <br>
In 13th ACM Multimedia Systems Conference (MMSys'22)

## Setup
We tested our code by running with,
- Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz×4, 32GiB RAM
- GPU specialized by GeForce RTX 1080 Ti
- Deepin

## Usage and Reference
For SE: [opensse-schemes](https://github.com/OpenSSE/opensse-schemes), compiled in `opensse-schemes/build`.

For generating hashing code of videos: we use [deephash](https://github.com/yuanli2333/Hadamard-Matrix-for-hashing).

For index: see `index.json` in `opensse-schemes/build/src`. use `-l` to import `index.json` to SSE database.

For showing results: see `check pic`, which indexes to corresponding videos.

## Disclaimer
PLEASE DO NOT USE THIS CODE TO ANY REAL-WORLD DATA OR COMPUTATION!

This code is just a proof-of-concept meant for performance testing of our framework ONLY. It is full of security vulnerabilities that facilitate testing, debugging, and performance measurements. In any real-world deployment, these vulnerabilities can be easily exploited to leak all user inputs.

This work started when the authors are very junior ... Back to Dec, 2017 ...

## Acknowledgement
Code: [opensse-schemes](https://github.com/OpenSSE/opensse-schemes), [deephash](https://github.com/yuanli2333/Hadamard-Matrix-for-hashing)

Papar: We appreciate immense help from Sherman S.M. Chow for idea discussion, constructive comments, rebuttal finalization, and paper writing. We thank Jiafan Wang, Huangting Wu, Lucien K.L. Ng, Yongjun Zhao, and Di Tang for the early-stage discussion and detailed comments.

ReadMe: [GForce](https://github.com/Lucieno/gforce-public)

## Citation
If you find our work is interesting, welcome to cite our paper,
```
@inproceedings{mmsys/ZhengTDF22,
  author    = {Yu Zheng and
               Heng Tian and
               Minxin Du and
               Chong Fu},
  title     = {Encrypted video search: scalable, modular, and content-similar},
  booktitle = {ACM Multimedia Systems Conference},
  year      = {2022}
}
```



