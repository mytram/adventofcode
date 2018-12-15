require './lib/solver'

lines = [
  '#1 @ 1,3: 4x4',
  '#2 @ 3,1: 4x4',
  '#3 @ 5,5: 2x2'
]

plane = Day03Solver.new(lines).call

expected = [[0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 1, 1, 1, 1, 0], [0, 0, 0, 1, 1, 1, 1, 0], [0, 1, 1, 2, 2, 1, 1, 0], [0, 1, 1, 2, 2, 1, 1, 0], [0, 1, 1, 1, 1, 1, 1, 0], [0, 1, 1, 1, 1, 1, 1, 0], [0, 0, 0, 0, 0, 0, 0, 0]]
assert(plane, expected)

plane = Day03Solver.new(Day03Solver.data).call

puts Day03Solver.overlapping_count plane

__END__

#1 @ 185,501: 17x15
#2 @ 821,899: 25x21
#3 @ 534,609: 17x26
#4 @ 316,464: 12x21
#5 @ 804,25: 28x15
#6 @ 805,352: 21x22
#7 @ 545,35: 14x18
#8 @ 213,564: 19x16
#9 @ 487,964: 13x11
#10 @ 793,662: 19x17
#11 @ 971,397: 25x16
#12 @ 751,682: 27x11
#13 @ 228,884: 28x26
#14 @ 912,431: 11x12
#15 @ 916,559: 29x27
#16 @ 646,318: 24x21
#17 @ 539,732: 14x18
#18 @ 728,600: 28x10
#19 @ 925,964: 15x11
#20 @ 178,363: 24x27
#21 @ 256,886: 28x27
#22 @ 564,777: 28x15
#23 @ 851,385: 29x15
#24 @ 357,540: 27x21
#25 @ 125,453: 16x21
#26 @ 594,575: 24x15
#27 @ 58,716: 28x15
#28 @ 111,588: 20x15
#29 @ 781,529: 17x23
#30 @ 282,67: 16x21
#31 @ 787,152: 23x10
#32 @ 35,10: 20x29
#33 @ 57,553: 23x25
#34 @ 923,977: 28x20
#35 @ 677,169: 23x14
#36 @ 75,833: 28x11
#37 @ 964,763: 12x10
#38 @ 269,470: 12x14
#39 @ 482,635: 14x5
#40 @ 917,215: 28x20
#41 @ 720,926: 23x22
#42 @ 517,348: 14x14
#43 @ 257,382: 13x16
#44 @ 584,413: 20x27
#45 @ 672,428: 14x26
#46 @ 270,953: 20x21
#47 @ 718,80: 18x18
#48 @ 101,492: 11x25
#49 @ 956,735: 22x12
#50 @ 596,705: 19x12
#51 @ 334,142: 22x13
#52 @ 916,549: 14x13
#53 @ 3,103: 11x18
#54 @ 115,241: 28x29
#55 @ 162,324: 18x14
#56 @ 717,210: 25x19
#57 @ 827,413: 21x13
#58 @ 610,478: 14x29
#59 @ 20,259: 20x26
#60 @ 369,86: 20x12
#61 @ 254,165: 27x14
#62 @ 809,15: 20x24
#63 @ 149,708: 20x10
#64 @ 302,264: 24x15
#65 @ 462,879: 19x26
#66 @ 872,943: 11x19
#67 @ 931,290: 18x12
#68 @ 204,728: 17x16
#69 @ 171,916: 19x10
#70 @ 917,71: 23x10
#71 @ 704,478: 11x29
#72 @ 518,89: 16x28
#73 @ 372,57: 15x16
#74 @ 960,365: 19x23
#75 @ 971,792: 26x28
#76 @ 682,940: 24x13
#77 @ 134,314: 27x18
#78 @ 119,248: 21x21
#79 @ 949,569: 16x15
#80 @ 156,584: 9x7
#81 @ 648,431: 28x13
#82 @ 861,764: 4x23
#83 @ 671,259: 12x11
#84 @ 864,930: 23x27
#85 @ 320,598: 27x11
#86 @ 485,262: 26x24
#87 @ 76,267: 25x26
#88 @ 265,567: 16x19
#89 @ 767,432: 21x21
#90 @ 798,2: 14x29
#91 @ 10,90: 12x18
#92 @ 389,844: 26x11
#93 @ 917,561: 25x14
#94 @ 581,756: 25x15
#95 @ 627,312: 11x23
#96 @ 61,735: 28x20
#97 @ 598,90: 12x12
#98 @ 583,691: 16x19
#99 @ 815,178: 15x27
#100 @ 432,641: 19x29
#101 @ 482,161: 17x12
#102 @ 505,60: 25x12
#103 @ 455,194: 13x20
#104 @ 91,814: 18x29
#105 @ 250,89: 13x21
#106 @ 78,836: 18x21
#107 @ 5,182: 10x6
#108 @ 62,167: 27x25
#109 @ 306,552: 16x22
#110 @ 605,76: 25x24
#111 @ 207,205: 17x21
#112 @ 318,661: 27x27
#113 @ 572,533: 22x26
#114 @ 352,839: 13x24
#115 @ 394,285: 20x23
#116 @ 373,428: 20x22
#117 @ 530,381: 20x19
#118 @ 368,52: 21x25
#119 @ 400,762: 29x18
#120 @ 829,844: 23x25
#121 @ 30,438: 17x17
#122 @ 389,770: 14x19
#123 @ 154,432: 17x25
#124 @ 530,456: 24x22
#125 @ 667,944: 20x22
#126 @ 391,599: 25x22
#127 @ 660,185: 12x18
#128 @ 594,108: 10x22
#129 @ 47,444: 17x16
#130 @ 915,416: 19x21
#131 @ 555,486: 23x26
#132 @ 116,180: 22x29
#133 @ 933,528: 22x17
#134 @ 537,732: 19x23
#135 @ 549,571: 16x15
#136 @ 734,673: 14x22
#137 @ 458,204: 14x27
#138 @ 930,965: 16x25
#139 @ 584,603: 26x18
#140 @ 628,246: 10x10
#141 @ 142,617: 13x15
#142 @ 743,669: 24x25
#143 @ 931,954: 28x29
#144 @ 223,301: 27x29
#145 @ 572,645: 14x12
#146 @ 242,430: 24x13
#147 @ 346,765: 3x5
#148 @ 415,957: 21x21
#149 @ 867,378: 27x29
#150 @ 4,705: 20x28
#151 @ 319,584: 17x22
#152 @ 830,885: 24x13
#153 @ 480,161: 19x13
#154 @ 365,468: 18x12
#155 @ 134,864: 23x25
#156 @ 269,467: 28x21
#157 @ 368,810: 18x14
#158 @ 976,746: 16x18
#159 @ 485,33: 27x13
#160 @ 184,244: 15x25
#161 @ 291,425: 25x28
#162 @ 593,699: 29x22
#163 @ 794,837: 23x26
#164 @ 193,487: 28x17
#165 @ 394,73: 28x13
#166 @ 984,895: 15x23
#167 @ 719,231: 18x27
#168 @ 247,253: 21x20
#169 @ 204,568: 16x10
#170 @ 140,140: 23x27
#171 @ 85,752: 26x10
#172 @ 506,264: 23x22
#173 @ 527,447: 26x29
#174 @ 568,916: 12x26
#175 @ 535,336: 15x15
#176 @ 921,905: 10x10
#177 @ 65,58: 16x19
#178 @ 105,213: 26x26
#179 @ 673,960: 25x19
#180 @ 76,727: 14x12
#181 @ 410,361: 21x25
#182 @ 589,943: 29x19
#183 @ 5,770: 27x12
#184 @ 623,212: 12x29
#185 @ 567,459: 17x24
#186 @ 955,359: 24x27
#187 @ 249,153: 21x17
#188 @ 337,537: 19x15
#189 @ 162,85: 10x14
#190 @ 624,285: 25x28
#191 @ 279,670: 24x28
#192 @ 865,541: 27x20
#193 @ 643,191: 29x12
#194 @ 288,405: 13x13
#195 @ 955,397: 18x25
#196 @ 609,509: 17x14
#197 @ 731,613: 27x19
#198 @ 867,720: 20x12
#199 @ 146,380: 28x10
#200 @ 589,506: 15x29
#201 @ 920,124: 10x27
#202 @ 590,557: 15x19
#203 @ 490,617: 22x13
#204 @ 634,423: 19x25
#205 @ 470,595: 14x24
#206 @ 370,762: 28x10
#207 @ 834,192: 12x12
#208 @ 282,401: 17x23
#209 @ 367,578: 11x13
#210 @ 845,123: 20x25
#211 @ 604,281: 23x17
#212 @ 475,168: 11x18
#213 @ 168,93: 23x24
#214 @ 844,285: 23x23
#215 @ 361,65: 12x21
#216 @ 467,202: 23x21
#217 @ 581,451: 10x16
#218 @ 3,841: 23x25
#219 @ 54,197: 13x21
#220 @ 960,382: 22x15
#221 @ 980,15: 18x23
#222 @ 943,722: 24x18
#223 @ 53,962: 10x13
#224 @ 175,430: 17x19
#225 @ 884,733: 18x14
#226 @ 927,85: 10x23
#227 @ 270,876: 28x23
#228 @ 606,826: 11x25
#229 @ 317,654: 22x26
#230 @ 277,631: 22x16
#231 @ 111,498: 10x28
#232 @ 420,667: 10x17
#233 @ 711,493: 26x14
#234 @ 420,634: 15x16
#235 @ 400,750: 24x29
#236 @ 479,628: 25x21
#237 @ 912,975: 23x22
#238 @ 821,662: 17x21
#239 @ 304,119: 22x18
#240 @ 95,522: 25x11
#241 @ 249,762: 17x14
#242 @ 723,819: 28x27
#243 @ 723,117: 23x22
#244 @ 77,268: 24x25
#245 @ 758,67: 21x16
#246 @ 708,758: 14x16
#247 @ 388,447: 29x17
#248 @ 359,338: 24x18
#249 @ 209,850: 23x29
#250 @ 769,6: 12x21
#251 @ 662,92: 13x12
#252 @ 744,238: 16x17
#253 @ 729,602: 10x19
#254 @ 929,592: 21x16
#255 @ 716,518: 4x5
#256 @ 300,409: 15x23
#257 @ 206,504: 15x25
#258 @ 336,44: 15x23
#259 @ 319,249: 18x28
#260 @ 223,796: 19x14
#261 @ 55,153: 11x21
#262 @ 316,410: 19x23
#263 @ 838,4: 15x17
#264 @ 501,525: 26x26
#265 @ 656,38: 16x20
#266 @ 467,672: 15x28
#267 @ 741,352: 24x11
#268 @ 20,679: 17x21
#269 @ 579,836: 17x24
#270 @ 115,880: 10x28
#271 @ 871,591: 10x13
#272 @ 964,470: 24x24
#273 @ 330,252: 20x18
#274 @ 201,683: 16x15
#275 @ 746,605: 15x11
#276 @ 92,281: 22x20
#277 @ 735,412: 16x29
#278 @ 977,398: 21x14
#279 @ 99,343: 16x17
#280 @ 316,336: 24x21
#281 @ 964,556: 15x21
#282 @ 619,646: 27x24
#283 @ 241,198: 28x20
#284 @ 735,721: 13x29
#285 @ 249,694: 16x10
#286 @ 501,368: 15x18
#287 @ 216,492: 17x26
#288 @ 711,45: 23x19
#289 @ 242,585: 20x23
#290 @ 192,545: 17x27
#291 @ 586,692: 20x24
#292 @ 94,925: 25x15
#293 @ 2,65: 12x26
#294 @ 852,386: 24x26
#295 @ 293,857: 8x9
#296 @ 676,864: 29x16
#297 @ 511,304: 12x23
#298 @ 60,711: 15x25
#299 @ 637,252: 29x23
#300 @ 195,525: 12x10
#301 @ 905,572: 19x17
#302 @ 394,279: 21x16
#303 @ 623,138: 14x11
#304 @ 147,619: 10x27
#305 @ 534,23: 10x16
#306 @ 284,58: 27x11
#307 @ 466,62: 29x20
#308 @ 424,76: 15x25
#309 @ 154,580: 15x18
#310 @ 819,934: 21x14
#311 @ 524,526: 18x17
#312 @ 774,305: 13x18
#313 @ 64,701: 22x19
#314 @ 930,596: 26x13
#315 @ 401,824: 25x24
#316 @ 792,374: 29x12
#317 @ 585,580: 24x26
#318 @ 366,438: 13x20
#319 @ 347,228: 15x27
#320 @ 538,347: 22x19
#321 @ 462,966: 29x22
#322 @ 2,79: 12x16
#323 @ 152,792: 29x15
#324 @ 315,100: 29x27
#325 @ 830,869: 15x11
#326 @ 8,640: 20x28
#327 @ 786,530: 22x18
#328 @ 575,520: 10x14
#329 @ 775,112: 25x10
#330 @ 915,589: 29x15
#331 @ 549,913: 11x17
#332 @ 635,250: 11x24
#333 @ 700,670: 27x21
#334 @ 598,323: 13x25
#335 @ 179,380: 14x4
#336 @ 315,416: 22x20
#337 @ 58,836: 15x11
#338 @ 206,69: 26x28
#339 @ 169,237: 21x14
#340 @ 627,703: 13x12
#341 @ 947,970: 24x16
#342 @ 466,446: 17x29
#343 @ 163,461: 12x20
#344 @ 8,190: 10x11
#345 @ 768,459: 26x16
#346 @ 876,832: 12x13
#347 @ 646,877: 27x15
#348 @ 927,13: 19x13
#349 @ 355,947: 16x24
#350 @ 441,25: 10x19
#351 @ 824,18: 26x12
#352 @ 598,566: 10x29
#353 @ 92,754: 15x4
#354 @ 426,74: 16x27
#355 @ 613,925: 19x28
#356 @ 94,233: 13x10
#357 @ 246,473: 21x19
#358 @ 887,836: 20x24
#359 @ 196,809: 25x15
#360 @ 796,648: 23x14
#361 @ 770,118: 28x24
#362 @ 708,266: 28x10
#363 @ 550,454: 17x22
#364 @ 729,247: 10x17
#365 @ 70,376: 15x18
#366 @ 665,541: 17x20
#367 @ 619,481: 13x19
#368 @ 721,402: 29x12
#369 @ 745,247: 15x29
#370 @ 149,497: 15x11
#371 @ 918,711: 16x12
#372 @ 915,613: 18x28
#373 @ 736,113: 15x20
#374 @ 839,854: 24x22
#375 @ 34,451: 22x20
#376 @ 260,379: 15x20
#377 @ 151,123: 20x14
#378 @ 207,386: 24x28
#379 @ 890,958: 18x27
#380 @ 344,682: 16x10
#381 @ 252,57: 12x13
#382 @ 383,804: 21x12
#383 @ 722,407: 17x26
#384 @ 776,110: 16x16
#385 @ 303,802: 24x21
#386 @ 814,948: 27x18
#387 @ 906,824: 27x22
#388 @ 917,660: 15x27
#389 @ 256,13: 18x21
#390 @ 287,964: 17x13
#391 @ 627,490: 24x10
#392 @ 694,948: 24x20
#393 @ 356,649: 22x27
#394 @ 686,769: 13x16
#395 @ 516,93: 11x17
#396 @ 345,5: 12x12
#397 @ 520,471: 19x11
#398 @ 719,63: 20x25
#399 @ 306,116: 24x16
#400 @ 621,81: 26x20
#401 @ 923,379: 10x27
#402 @ 873,934: 15x19
#403 @ 264,145: 15x16
#404 @ 87,550: 10x26
#405 @ 829,793: 14x10
#406 @ 178,333: 10x22
#407 @ 145,324: 15x21
#408 @ 883,955: 27x12
#409 @ 841,479: 23x14
#410 @ 372,760: 19x16
#411 @ 873,932: 10x14
#412 @ 345,457: 12x11
#413 @ 615,219: 25x23
#414 @ 683,24: 25x25
#415 @ 627,118: 23x25
#416 @ 263,319: 27x24
#417 @ 906,622: 14x22
#418 @ 699,824: 17x19
#419 @ 386,467: 26x17
#420 @ 866,965: 19x11
#421 @ 349,637: 26x26
#422 @ 343,226: 11x19
#423 @ 555,278: 24x27
#424 @ 516,359: 23x19
#425 @ 928,490: 27x16
#426 @ 777,873: 14x10
#427 @ 675,947: 23x28
#428 @ 335,760: 13x24
#429 @ 30,233: 26x28
#430 @ 272,331: 28x21
#431 @ 906,147: 19x15
#432 @ 516,844: 20x23
#433 @ 311,238: 24x14
#434 @ 329,440: 16x29
#435 @ 77,883: 21x21
#436 @ 458,87: 28x11
#437 @ 495,494: 26x13
#438 @ 203,253: 21x12
#439 @ 709,920: 15x21
#440 @ 433,580: 24x19
#441 @ 456,862: 15x18
#442 @ 73,229: 10x22
#443 @ 677,381: 28x29
#444 @ 810,362: 24x23
#445 @ 783,318: 20x21
#446 @ 780,530: 14x21
#447 @ 577,349: 19x26
#448 @ 985,396: 3x8
#449 @ 631,239: 22x10
#450 @ 728,741: 12x25
#451 @ 276,731: 21x28
#452 @ 712,64: 18x27
#453 @ 522,474: 10x28
#454 @ 794,233: 21x28
#455 @ 54,421: 21x25
#456 @ 659,220: 14x25
#457 @ 46,415: 18x18
#458 @ 494,267: 27x10
#459 @ 924,69: 13x22
#460 @ 238,377: 10x25
#461 @ 201,691: 12x28
#462 @ 925,217: 24x16
#463 @ 973,932: 10x28
#464 @ 714,515: 10x14
#465 @ 145,794: 28x28
#466 @ 288,170: 20x14
#467 @ 809,401: 24x17
#468 @ 535,376: 13x19
#469 @ 539,198: 25x26
#470 @ 598,378: 22x22
#471 @ 893,774: 12x11
#472 @ 535,323: 15x19
#473 @ 704,59: 15x13
#474 @ 16,778: 22x26
#475 @ 287,810: 21x13
#476 @ 785,83: 23x15
#477 @ 160,318: 27x27
#478 @ 64,373: 17x29
#479 @ 941,7: 12x17
#480 @ 620,223: 15x12
#481 @ 521,782: 19x21
#482 @ 675,253: 20x17
#483 @ 553,773: 12x27
#484 @ 401,458: 13x23
#485 @ 348,552: 22x23
#486 @ 367,417: 26x24
#487 @ 562,907: 19x26
#488 @ 569,26: 18x29
#489 @ 326,805: 12x21
#490 @ 617,360: 28x10
#491 @ 468,161: 29x23
#492 @ 888,204: 29x26
#493 @ 900,951: 17x11
#494 @ 575,864: 18x13
#495 @ 44,696: 26x23
#496 @ 830,53: 23x21
#497 @ 909,936: 13x16
#498 @ 352,639: 19x15
#499 @ 967,797: 19x28
#500 @ 490,81: 20x13
#501 @ 86,767: 20x16
#502 @ 509,190: 16x16
#503 @ 32,960: 29x25
#504 @ 547,473: 10x18
#505 @ 366,908: 27x20
#506 @ 483,924: 12x21
#507 @ 346,16: 16x17
#508 @ 658,43: 5x10
#509 @ 482,580: 3x11
#510 @ 922,902: 25x13
#511 @ 138,389: 21x22
#512 @ 182,213: 26x27
#513 @ 415,849: 25x18
#514 @ 755,794: 25x17
#515 @ 293,957: 29x23
#516 @ 800,144: 18x12
#517 @ 581,866: 26x11
#518 @ 12,410: 16x21
#519 @ 513,401: 15x15
#520 @ 218,346: 19x13
#521 @ 336,664: 20x13
#522 @ 205,799: 14x26
#523 @ 867,839: 5x10
#524 @ 730,226: 10x20
#525 @ 227,952: 21x12
#526 @ 399,207: 15x11
#527 @ 933,193: 28x16
#528 @ 552,498: 11x23
#529 @ 357,85: 12x29
#530 @ 480,448: 16x27
#531 @ 825,26: 11x23
#532 @ 573,878: 12x18
#533 @ 819,363: 19x21
#534 @ 917,391: 14x13
#535 @ 455,25: 17x28
#536 @ 899,773: 13x26
#537 @ 330,826: 28x18
#538 @ 248,893: 18x27
#539 @ 489,892: 20x14
#540 @ 137,469: 28x26
#541 @ 942,224: 19x26
#542 @ 604,77: 16x20
#543 @ 315,891: 26x28
#544 @ 404,940: 16x21
#545 @ 37,938: 13x29
#546 @ 190,158: 29x12
#547 @ 868,116: 15x26
#548 @ 135,233: 13x17
#549 @ 829,403: 26x11
#550 @ 276,914: 26x19
#551 @ 715,722: 12x21
#552 @ 369,155: 27x10
#553 @ 192,160: 19x7
#554 @ 587,279: 10x26
#555 @ 628,505: 21x10
#556 @ 286,118: 25x14
#557 @ 264,760: 29x26
#558 @ 730,253: 29x13
#559 @ 378,2: 22x29
#560 @ 63,941: 28x26
#561 @ 188,465: 25x15
#562 @ 903,97: 16x11
#563 @ 770,980: 14x13
#564 @ 274,14: 24x23
#565 @ 951,380: 21x27
#566 @ 500,375: 18x10
#567 @ 563,465: 29x23
#568 @ 466,146: 14x12
#569 @ 110,276: 14x18
#570 @ 375,425: 11x12
#571 @ 770,362: 12x14
#572 @ 57,455: 24x17
#573 @ 255,900: 22x19
#574 @ 878,548: 27x22
#575 @ 580,710: 28x28
#576 @ 595,374: 28x27
#577 @ 691,404: 16x21
#578 @ 251,677: 15x23
#579 @ 737,245: 20x21
#580 @ 718,761: 20x24
#581 @ 967,938: 14x22
#582 @ 463,891: 25x13
#583 @ 402,127: 12x29
#584 @ 171,212: 6x7
#585 @ 558,190: 13x26
#586 @ 277,879: 17x4
#587 @ 265,718: 25x29
#588 @ 122,453: 29x20
#589 @ 481,942: 17x27
#590 @ 654,823: 13x28
#591 @ 879,397: 20x18
#592 @ 816,456: 24x17
#593 @ 480,578: 10x17
#594 @ 131,210: 22x10
#595 @ 893,440: 29x26
#596 @ 900,438: 20x23
#597 @ 431,631: 14x20
#598 @ 232,355: 29x25
#599 @ 561,366: 10x23
#600 @ 731,584: 25x26
#601 @ 95,932: 17x18
#602 @ 231,555: 20x22
#603 @ 341,863: 15x19
#604 @ 196,340: 28x12
#605 @ 275,41: 16x27
#606 @ 508,604: 13x27
#607 @ 825,98: 22x12
#608 @ 157,434: 7x6
#609 @ 206,627: 18x12
#610 @ 881,624: 23x29
#611 @ 268,143: 13x14
#612 @ 526,299: 24x18
#613 @ 348,669: 11x24
#614 @ 984,468: 14x27
#615 @ 103,441: 20x26
#616 @ 696,301: 13x27
#617 @ 31,660: 11x28
#618 @ 541,273: 20x16
#619 @ 539,487: 14x10
#620 @ 48,328: 11x27
#621 @ 281,829: 12x23
#622 @ 622,349: 14x28
#623 @ 138,445: 18x19
#624 @ 60,256: 26x23
#625 @ 713,210: 19x17
#626 @ 349,261: 15x24
#627 @ 710,171: 11x26
#628 @ 800,431: 20x26
#629 @ 200,376: 26x28
#630 @ 743,623: 24x13
#631 @ 574,654: 28x13
#632 @ 383,549: 25x24
#633 @ 438,572: 23x27
#634 @ 340,423: 19x18
#635 @ 842,111: 11x20
#636 @ 335,686: 10x21
#637 @ 790,648: 19x26
#638 @ 494,944: 11x24
#639 @ 213,223: 13x27
#640 @ 47,243: 23x26
#641 @ 554,689: 16x10
#642 @ 737,593: 12x20
#643 @ 160,453: 12x24
#644 @ 622,529: 17x15
#645 @ 689,82: 5x4
#646 @ 4,186: 26x22
#647 @ 602,78: 20x21
#648 @ 166,712: 16x23
#649 @ 118,876: 23x27
#650 @ 498,618: 15x25
#651 @ 636,67: 14x28
#652 @ 324,683: 27x28
#653 @ 626,621: 28x29
#654 @ 383,811: 12x18
#655 @ 614,263: 29x15
#656 @ 813,662: 13x26
#657 @ 289,831: 23x26
#658 @ 359,387: 11x13
#659 @ 43,260: 11x17
#660 @ 605,698: 16x13
#661 @ 903,67: 21x29
#662 @ 852,784: 14x10
#663 @ 684,653: 25x20
#664 @ 662,95: 29x11
#665 @ 169,568: 20x12
#666 @ 95,622: 22x25
#667 @ 53,805: 12x27
#668 @ 516,451: 27x20
#669 @ 424,595: 29x25
#670 @ 923,615: 18x21
#671 @ 253,334: 29x11
#672 @ 206,491: 16x12
#673 @ 577,104: 18x23
#674 @ 131,642: 19x28
#675 @ 951,918: 10x26
#676 @ 233,576: 19x18
#677 @ 563,875: 27x19
#678 @ 850,270: 24x28
#679 @ 157,387: 18x15
#680 @ 351,834: 20x17
#681 @ 774,664: 12x11
#682 @ 510,117: 26x18
#683 @ 848,782: 22x15
#684 @ 524,440: 17x12
#685 @ 414,601: 21x20
#686 @ 274,644: 14x13
#687 @ 623,514: 10x24
#688 @ 24,6: 22x11
#689 @ 425,97: 14x16
#690 @ 924,371: 21x29
#691 @ 457,875: 29x19
#692 @ 785,442: 19x24
#693 @ 301,258: 18x11
#694 @ 380,676: 18x14
#695 @ 968,439: 16x16
#696 @ 358,669: 11x19
#697 @ 348,444: 19x22
#698 @ 151,430: 14x20
#699 @ 151,361: 12x29
#700 @ 181,252: 20x15
#701 @ 804,360: 11x16
#702 @ 824,28: 25x27
#703 @ 474,137: 11x18
#704 @ 820,175: 20x26
#705 @ 586,354: 13x14
#706 @ 915,97: 19x28
#707 @ 542,523: 26x11
#708 @ 360,574: 11x21
#709 @ 948,421: 23x18
#710 @ 782,107: 19x14
#711 @ 1,656: 26x23
#712 @ 154,457: 14x24
#713 @ 172,232: 26x11
#714 @ 316,138: 19x11
#715 @ 613,224: 26x14
#716 @ 696,874: 23x12
#717 @ 908,672: 13x29
#718 @ 283,27: 25x26
#719 @ 22,738: 11x13
#720 @ 838,808: 25x29
#721 @ 562,384: 14x17
#722 @ 260,764: 13x24
#723 @ 581,839: 12x8
#724 @ 336,6: 11x21
#725 @ 73,742: 16x14
#726 @ 75,452: 18x10
#727 @ 693,319: 28x16
#728 @ 821,511: 15x23
#729 @ 848,812: 10x19
#730 @ 830,588: 22x26
#731 @ 876,375: 27x24
#732 @ 754,436: 23x27
#733 @ 868,45: 16x19
#734 @ 277,416: 17x16
#735 @ 978,22: 20x18
#736 @ 26,661: 14x24
#737 @ 294,80: 20x13
#738 @ 713,495: 14x28
#739 @ 487,804: 24x20
#740 @ 460,479: 10x15
#741 @ 379,93: 13x16
#742 @ 594,151: 23x29
#743 @ 125,188: 25x17
#744 @ 605,260: 13x28
#745 @ 802,439: 8x6
#746 @ 113,20: 29x16
#747 @ 66,388: 12x8
#748 @ 921,120: 14x15
#749 @ 193,507: 12x25
#750 @ 271,129: 18x19
#751 @ 317,963: 24x25
#752 @ 478,590: 10x13
#753 @ 397,816: 19x24
#754 @ 932,974: 29x23
#755 @ 853,674: 28x28
#756 @ 93,224: 10x29
#757 @ 217,188: 16x25
#758 @ 569,3: 13x14
#759 @ 625,456: 29x26
#760 @ 527,845: 21x27
#761 @ 802,434: 13x18
#762 @ 569,564: 11x22
#763 @ 28,922: 20x26
#764 @ 657,361: 22x16
#765 @ 242,267: 21x29
#766 @ 758,46: 28x10
#767 @ 880,108: 22x17
#768 @ 979,461: 11x12
#769 @ 324,189: 14x13
#770 @ 214,622: 29x23
#771 @ 169,205: 14x24
#772 @ 464,889: 26x11
#773 @ 174,220: 17x27
#774 @ 587,742: 14x17
#775 @ 7,738: 13x15
#776 @ 668,517: 20x18
#777 @ 558,85: 16x10
#778 @ 968,836: 20x10
#779 @ 770,463: 5x4
#780 @ 255,914: 17x11
#781 @ 715,39: 22x27
#782 @ 364,907: 23x21
#783 @ 358,966: 21x14
#784 @ 325,34: 16x16
#785 @ 584,600: 19x23
#786 @ 137,236: 6x10
#787 @ 290,331: 24x28
#788 @ 401,403: 16x11
#789 @ 358,268: 11x14
#790 @ 10,722: 20x17
#791 @ 280,583: 14x15
#792 @ 488,882: 26x24
#793 @ 890,716: 22x19
#794 @ 531,265: 20x17
#795 @ 325,581: 17x18
#796 @ 341,742: 26x20
#797 @ 745,105: 25x16
#798 @ 411,676: 13x17
#799 @ 304,907: 20x27
#800 @ 326,332: 17x22
#801 @ 939,986: 23x13
#802 @ 50,827: 17x24
#803 @ 540,470: 18x20
#804 @ 535,333: 27x19
#805 @ 82,386: 21x22
#806 @ 197,247: 27x17
#807 @ 814,841: 24x19
#808 @ 101,527: 18x12
#809 @ 962,305: 20x25
#810 @ 807,54: 11x13
#811 @ 761,516: 28x18
#812 @ 479,796: 15x27
#813 @ 372,456: 24x19
#814 @ 907,503: 24x21
#815 @ 668,944: 14x27
#816 @ 163,79: 18x27
#817 @ 358,104: 17x16
#818 @ 359,424: 24x27
#819 @ 102,764: 22x16
#820 @ 912,408: 24x11
#821 @ 224,544: 19x15
#822 @ 593,796: 13x15
#823 @ 79,780: 10x21
#824 @ 543,566: 20x26
#825 @ 864,114: 11x16
#826 @ 252,15: 10x19
#827 @ 61,81: 10x18
#828 @ 949,230: 22x16
#829 @ 698,779: 11x29
#830 @ 365,958: 11x27
#831 @ 820,831: 20x29
#832 @ 912,582: 14x17
#833 @ 252,272: 24x15
#834 @ 812,504: 14x18
#835 @ 892,256: 26x22
#836 @ 94,480: 26x24
#837 @ 195,509: 7x12
#838 @ 497,639: 22x21
#839 @ 68,842: 28x29
#840 @ 520,496: 26x12
#841 @ 15,898: 28x27
#842 @ 844,49: 15x23
#843 @ 334,953: 13x10
#844 @ 482,79: 23x10
#845 @ 660,316: 20x24
#846 @ 357,670: 25x17
#847 @ 224,292: 11x13
#848 @ 153,374: 19x27
#849 @ 123,534: 20x18
#850 @ 661,357: 15x22
#851 @ 905,263: 16x12
#852 @ 259,268: 20x11
#853 @ 603,727: 22x24
#854 @ 856,630: 26x19
#855 @ 740,726: 4x14
#856 @ 252,492: 24x27
#857 @ 713,905: 16x11
#858 @ 318,532: 29x12
#859 @ 39,892: 13x26
#860 @ 846,585: 29x18
#861 @ 70,371: 13x13
#862 @ 199,732: 21x10
#863 @ 568,841: 12x12
#864 @ 521,279: 16x26
#865 @ 366,425: 17x26
#866 @ 691,762: 23x10
#867 @ 586,800: 12x23
#868 @ 21,938: 26x12
#869 @ 72,749: 20x13
#870 @ 595,845: 15x13
#871 @ 388,702: 14x15
#872 @ 529,574: 25x26
#873 @ 181,543: 12x27
#874 @ 214,817: 15x22
#875 @ 748,452: 16x21
#876 @ 790,955: 20x26
#877 @ 601,472: 17x14
#878 @ 742,172: 27x29
#879 @ 100,927: 15x8
#880 @ 878,833: 29x27
#881 @ 20,885: 21x18
#882 @ 763,454: 16x29
#883 @ 597,56: 18x28
#884 @ 485,43: 28x26
#885 @ 233,727: 12x13
#886 @ 39,573: 29x26
#887 @ 787,81: 21x14
#888 @ 857,376: 11x12
#889 @ 904,626: 20x11
#890 @ 863,836: 27x19
#891 @ 771,793: 16x11
#892 @ 349,746: 17x24
#893 @ 450,17: 29x28
#894 @ 643,338: 10x10
#895 @ 2,659: 19x15
#896 @ 72,429: 11x18
#897 @ 908,68: 26x27
#898 @ 264,536: 12x12
#899 @ 673,11: 13x16
#900 @ 961,340: 11x17
#901 @ 724,662: 23x11
#902 @ 364,336: 16x25
#903 @ 687,639: 19x23
#904 @ 851,398: 27x17
#905 @ 57,427: 27x22
#906 @ 106,495: 14x16
#907 @ 524,469: 23x15
#908 @ 631,237: 10x11
#909 @ 977,798: 22x21
#910 @ 158,348: 28x14
#911 @ 382,65: 18x28
#912 @ 54,950: 16x15
#913 @ 244,471: 26x24
#914 @ 733,604: 19x11
#915 @ 427,618: 12x24
#916 @ 276,152: 14x27
#917 @ 147,379: 26x14
#918 @ 232,286: 11x21
#919 @ 840,48: 18x15
#920 @ 146,204: 24x12
#921 @ 204,630: 12x17
#922 @ 140,118: 18x15
#923 @ 54,49: 18x16
#924 @ 553,862: 27x17
#925 @ 570,28: 21x29
#926 @ 816,390: 11x28
#927 @ 308,766: 15x17
#928 @ 628,641: 10x24
#929 @ 301,335: 12x10
#930 @ 242,61: 14x18
#931 @ 778,531: 25x23
#932 @ 304,763: 20x11
#933 @ 866,364: 12x24
#934 @ 714,705: 29x28
#935 @ 728,605: 21x28
#936 @ 787,60: 27x28
#937 @ 713,783: 24x20
#938 @ 779,128: 14x26
#939 @ 958,95: 13x21
#940 @ 122,246: 15x10
#941 @ 778,656: 28x13
#942 @ 482,76: 25x27
#943 @ 235,134: 16x11
#944 @ 12,380: 13x25
#945 @ 100,832: 27x23
#946 @ 813,219: 11x17
#947 @ 295,335: 17x10
#948 @ 519,485: 27x25
#949 @ 588,514: 26x29
#950 @ 967,924: 21x24
#951 @ 213,787: 19x16
#952 @ 503,861: 22x28
#953 @ 374,642: 11x25
#954 @ 524,523: 20x14
#955 @ 402,535: 28x24
#956 @ 763,324: 22x14
#957 @ 526,494: 19x17
#958 @ 828,404: 13x23
#959 @ 656,980: 16x16
#960 @ 793,533: 27x11
#961 @ 824,472: 24x26
#962 @ 807,357: 20x17
#963 @ 176,615: 19x25
#964 @ 273,110: 11x28
#965 @ 720,207: 12x13
#966 @ 666,233: 19x23
#967 @ 801,649: 29x17
#968 @ 109,731: 18x12
#969 @ 182,99: 16x29
#970 @ 174,576: 11x25
#971 @ 515,242: 21x16
#972 @ 129,840: 11x24
#973 @ 490,14: 13x18
#974 @ 825,843: 15x10
#975 @ 474,403: 20x15
#976 @ 708,128: 23x13
#977 @ 263,491: 21x20
#978 @ 313,563: 19x23
#979 @ 578,912: 19x15
#980 @ 621,299: 20x10
#981 @ 206,567: 21x27
#982 @ 420,857: 15x10
#983 @ 857,199: 17x26
#984 @ 707,892: 28x14
#985 @ 109,511: 23x28
#986 @ 948,337: 19x23
#987 @ 589,883: 24x16
#988 @ 20,912: 16x13
#989 @ 420,604: 12x12
#990 @ 587,271: 25x15
#991 @ 723,796: 10x21
#992 @ 385,292: 22x15
#993 @ 505,886: 28x18
#994 @ 532,365: 22x25
#995 @ 100,678: 22x19
#996 @ 752,600: 12x19
#997 @ 799,190: 19x19
#998 @ 21,695: 13x20
#999 @ 629,754: 18x15
#1000 @ 32,970: 24x21
#1001 @ 510,70: 24x28
#1002 @ 224,184: 24x17
#1003 @ 104,332: 24x12
#1004 @ 528,526: 29x18
#1005 @ 24,257: 15x11
#1006 @ 687,259: 24x27
#1007 @ 439,591: 19x28
#1008 @ 771,252: 17x25
#1009 @ 133,425: 27x26
#1010 @ 100,267: 23x21
#1011 @ 770,6: 10x10
#1012 @ 281,397: 13x24
#1013 @ 639,523: 12x17
#1014 @ 336,465: 16x17
#1015 @ 279,132: 22x16
#1016 @ 401,903: 16x23
#1017 @ 826,513: 17x10
#1018 @ 249,593: 23x19
#1019 @ 705,190: 22x27
#1020 @ 402,853: 17x23
#1021 @ 547,274: 13x29
#1022 @ 271,179: 18x24
#1023 @ 156,804: 12x14
#1024 @ 795,650: 22x26
#1025 @ 438,227: 15x20
#1026 @ 148,775: 18x22
#1027 @ 289,819: 28x14
#1028 @ 156,130: 15x13
#1029 @ 971,646: 11x27
#1030 @ 542,371: 25x17
#1031 @ 57,215: 19x12
#1032 @ 938,227: 22x19
#1033 @ 770,874: 20x18
#1034 @ 796,765: 12x10
#1035 @ 896,565: 21x23
#1036 @ 868,931: 12x19
#1037 @ 395,759: 16x27
#1038 @ 324,577: 12x24
#1039 @ 913,104: 15x17
#1040 @ 414,277: 13x21
#1041 @ 139,503: 17x25
#1042 @ 647,833: 11x29
#1043 @ 763,357: 24x13
#1044 @ 859,959: 11x29
#1045 @ 449,591: 28x18
#1046 @ 622,604: 27x22
#1047 @ 111,44: 15x28
#1048 @ 884,298: 12x12
#1049 @ 370,955: 19x14
#1050 @ 26,385: 19x23
#1051 @ 929,58: 17x18
#1052 @ 508,771: 28x26
#1053 @ 176,374: 23x17
#1054 @ 422,89: 13x24
#1055 @ 380,528: 24x17
#1056 @ 258,702: 22x13
#1057 @ 255,399: 17x13
#1058 @ 777,88: 27x22
#1059 @ 377,780: 19x22
#1060 @ 934,987: 28x10
#1061 @ 921,150: 26x26
#1062 @ 614,97: 29x16
#1063 @ 528,191: 25x15
#1064 @ 643,867: 15x12
#1065 @ 918,367: 28x21
#1066 @ 493,183: 24x25
#1067 @ 581,520: 23x24
#1068 @ 589,443: 17x17
#1069 @ 944,612: 3x8
#1070 @ 32,344: 24x15
#1071 @ 305,477: 12x22
#1072 @ 547,456: 19x13
#1073 @ 147,798: 19x18
#1074 @ 233,585: 16x25
#1075 @ 192,557: 22x19
#1076 @ 295,400: 12x28
#1077 @ 187,556: 14x11
#1078 @ 775,368: 19x18
#1079 @ 724,706: 10x24
#1080 @ 961,836: 22x19
#1081 @ 764,337: 15x17
#1082 @ 84,395: 17x10
#1083 @ 310,340: 17x19
#1084 @ 750,51: 16x24
#1085 @ 875,405: 13x18
#1086 @ 956,747: 20x21
#1087 @ 523,392: 28x20
#1088 @ 120,580: 12x21
#1089 @ 12,834: 10x12
#1090 @ 949,916: 10x27
#1091 @ 85,546: 27x25
#1092 @ 953,101: 15x12
#1093 @ 719,713: 14x20
#1094 @ 698,612: 21x25
#1095 @ 687,64: 11x26
#1096 @ 153,139: 27x28
#1097 @ 831,187: 28x17
#1098 @ 825,938: 25x11
#1099 @ 564,817: 23x25
#1100 @ 455,684: 17x22
#1101 @ 823,656: 18x23
#1102 @ 94,891: 29x23
#1103 @ 828,492: 19x19
#1104 @ 275,163: 27x17
#1105 @ 375,462: 19x27
#1106 @ 284,67: 17x29
#1107 @ 509,248: 27x11
#1108 @ 626,284: 17x14
#1109 @ 356,766: 22x24
#1110 @ 897,246: 11x21
#1111 @ 546,481: 28x29
#1112 @ 834,856: 18x23
#1113 @ 186,241: 17x17
#1114 @ 807,640: 17x24
#1115 @ 925,717: 11x20
#1116 @ 737,270: 25x25
#1117 @ 545,379: 12x21
#1118 @ 255,148: 24x29
#1119 @ 975,880: 20x28
#1120 @ 139,853: 27x23
#1121 @ 52,830: 3x12
#1122 @ 747,631: 16x22
#1123 @ 441,606: 14x27
#1124 @ 399,699: 24x13
#1125 @ 970,630: 13x23
#1126 @ 403,342: 29x24
#1127 @ 964,940: 15x24
#1128 @ 729,673: 19x23
#1129 @ 675,553: 28x14
#1130 @ 715,594: 22x27
#1131 @ 690,549: 10x19
#1132 @ 719,395: 27x28
#1133 @ 116,233: 18x24
#1134 @ 844,199: 19x28
#1135 @ 242,205: 19x11
#1136 @ 368,154: 12x13
#1137 @ 685,135: 16x23
#1138 @ 836,871: 13x14
#1139 @ 885,952: 11x29
#1140 @ 856,671: 25x14
#1141 @ 56,234: 23x28
#1142 @ 712,802: 26x24
#1143 @ 452,246: 21x29
#1144 @ 800,881: 22x24
#1145 @ 353,825: 10x24
#1146 @ 132,549: 15x20
#1147 @ 75,875: 22x14
#1148 @ 708,840: 18x24
#1149 @ 218,873: 13x28
#1150 @ 780,526: 11x14
#1151 @ 747,228: 17x18
#1152 @ 876,34: 11x24
#1153 @ 945,918: 14x12
#1154 @ 328,760: 25x14
#1155 @ 855,721: 26x20
#1156 @ 32,963: 23x20
#1157 @ 522,495: 19x25
#1158 @ 773,230: 27x23
#1159 @ 951,772: 26x25
#1160 @ 95,632: 25x21
#1161 @ 979,418: 11x26
#1162 @ 691,496: 29x24
#1163 @ 256,272: 24x15
#1164 @ 337,946: 11x22
#1165 @ 383,209: 27x11
#1166 @ 785,149: 12x23
#1167 @ 564,6: 23x17
#1168 @ 746,666: 14x19
#1169 @ 402,376: 10x29
#1170 @ 506,323: 14x21
#1171 @ 801,757: 11x17
#1172 @ 397,365: 15x11
#1173 @ 259,915: 15x24
#1174 @ 681,130: 22x10
#1175 @ 249,569: 13x26
#1176 @ 329,559: 22x26
#1177 @ 670,414: 12x21
#1178 @ 683,422: 12x17
#1179 @ 804,846: 20x14
#1180 @ 678,414: 19x26
#1181 @ 155,144: 25x11
#1182 @ 369,801: 14x12
#1183 @ 11,434: 20x10
#1184 @ 832,451: 17x26
#1185 @ 971,769: 25x18
#1186 @ 172,620: 12x24
#1187 @ 864,602: 26x27
#1188 @ 779,298: 21x17
#1189 @ 455,476: 21x21
#1190 @ 540,20: 20x20
#1191 @ 798,655: 17x26
#1192 @ 902,63: 26x23
#1193 @ 201,513: 18x16
#1194 @ 463,393: 21x23
#1195 @ 971,288: 14x18
#1196 @ 344,524: 24x28
#1197 @ 407,380: 17x16
#1198 @ 8,733: 22x12
#1199 @ 785,524: 13x29
#1200 @ 181,418: 29x24
#1201 @ 650,345: 28x11
#1202 @ 610,60: 18x27
#1203 @ 521,878: 27x22
#1204 @ 547,900: 15x23
#1205 @ 90,944: 17x19
#1206 @ 638,508: 13x13
#1207 @ 916,424: 20x17
#1208 @ 89,839: 17x11
#1209 @ 32,781: 25x25
#1210 @ 195,240: 19x27
#1211 @ 934,607: 18x18
#1212 @ 227,549: 15x25
#1213 @ 79,864: 13x27
#1214 @ 182,555: 13x12
#1215 @ 841,854: 24x19
#1216 @ 508,33: 28x13
#1217 @ 632,271: 28x13
#1218 @ 970,751: 14x19
#1219 @ 58,954: 19x18
#1220 @ 435,179: 11x23
#1221 @ 872,309: 20x14
#1222 @ 833,783: 16x15
#1223 @ 263,672: 17x29
#1224 @ 760,302: 26x16
#1225 @ 181,677: 11x19
#1226 @ 112,490: 18x15
#1227 @ 362,379: 15x14
#1228 @ 181,239: 26x22
#1229 @ 262,533: 10x25
#1230 @ 310,680: 13x29
#1231 @ 817,95: 25x14
#1232 @ 375,11: 29x11
#1233 @ 149,860: 18x28
#1234 @ 564,520: 28x19
#1235 @ 613,163: 22x29
#1236 @ 331,399: 23x21
#1237 @ 642,486: 27x14
#1238 @ 308,43: 27x27
#1239 @ 751,967: 29x18
#1240 @ 243,417: 27x17
#1241 @ 235,735: 15x22
#1242 @ 798,217: 19x26
#1243 @ 707,649: 20x17
#1244 @ 230,93: 28x10
#1245 @ 217,613: 11x12
#1246 @ 210,849: 28x26
#1247 @ 381,794: 23x27
#1248 @ 505,349: 26x17
#1249 @ 540,633: 19x25
#1250 @ 516,353: 27x11
#1251 @ 926,985: 11x10
#1252 @ 919,287: 24x11
#1253 @ 680,55: 26x15
#1254 @ 65,781: 24x22
#1255 @ 537,566: 16x13
#1256 @ 572,88: 25x27
#1257 @ 563,464: 19x18
#1258 @ 391,846: 20x25
#1259 @ 390,775: 22x21
#1260 @ 397,113: 17x15
#1261 @ 181,386: 10x12
#1262 @ 291,855: 19x18
#1263 @ 488,932: 15x17
#1264 @ 927,852: 23x18
#1265 @ 857,762: 13x28
#1266 @ 954,529: 18x18
#1267 @ 217,228: 14x27
#1268 @ 799,436: 15x19
#1269 @ 945,209: 18x25
#1270 @ 336,215: 12x14
#1271 @ 95,877: 22x11
#1272 @ 519,448: 13x24
#1273 @ 587,511: 13x12
#1274 @ 692,51: 13x13
#1275 @ 122,38: 20x20
#1276 @ 613,279: 20x17
#1277 @ 625,704: 14x10
#1278 @ 521,192: 11x11
#1279 @ 237,607: 28x13
#1280 @ 836,197: 26x19
#1281 @ 430,192: 27x10
#1282 @ 948,898: 25x25
#1283 @ 628,293: 24x26
#1284 @ 860,862: 17x17
#1285 @ 910,197: 16x24
#1286 @ 554,572: 25x24
#1287 @ 178,668: 23x15
#1288 @ 890,105: 10x19
#1289 @ 224,959: 11x11
#1290 @ 875,369: 27x27
#1291 @ 241,213: 12x23
#1292 @ 293,337: 18x21
#1293 @ 462,83: 28x20
#1294 @ 344,549: 10x24
#1295 @ 367,450: 11x26
#1296 @ 60,830: 28x22
#1297 @ 3,179: 16x17
#1298 @ 162,339: 20x13
#1299 @ 738,61: 28x17
#1300 @ 794,957: 28x29
#1301 @ 407,906: 14x19
#1302 @ 444,577: 21x10
#1303 @ 424,862: 29x17
#1304 @ 255,783: 20x27
#1305 @ 636,512: 11x28
#1306 @ 275,106: 25x11
#1307 @ 205,70: 20x23
#1308 @ 610,316: 19x10
#1309 @ 377,68: 18x13
#1310 @ 663,987: 13x13
#1311 @ 372,82: 25x29
#1312 @ 349,881: 11x10
#1313 @ 626,261: 11x16
#1314 @ 762,250: 13x23
#1315 @ 646,267: 14x26
#1316 @ 117,678: 10x25
#1317 @ 914,113: 15x26
#1318 @ 515,88: 13x17
#1319 @ 188,510: 18x29
#1320 @ 892,964: 11x19
#1321 @ 11,382: 21x12
#1322 @ 957,930: 25x25
#1323 @ 47,77: 20x25
#1324 @ 458,31: 20x18
#1325 @ 809,53: 25x10
#1326 @ 829,515: 7x5
#1327 @ 618,72: 10x10
#1328 @ 918,859: 23x16
#1329 @ 159,348: 22x28
#1330 @ 769,460: 18x10
#1331 @ 878,922: 14x22
#1332 @ 661,559: 13x28
#1333 @ 815,418: 13x11
#1334 @ 831,197: 11x17
#1335 @ 411,545: 25x18
#1336 @ 509,285: 19x22
#1337 @ 926,885: 29x17
#1338 @ 757,589: 16x27
#1339 @ 172,803: 27x27
#1340 @ 269,161: 17x29
#1341 @ 469,185: 22x28
#1342 @ 981,391: 11x25
#1343 @ 314,195: 29x20
#1344 @ 468,797: 10x22
#1345 @ 477,79: 29x24
#1346 @ 884,560: 22x22
#1347 @ 460,798: 18x13
#1348 @ 871,61: 26x10
#1349 @ 115,894: 11x17
#1350 @ 842,883: 17x11
#1351 @ 38,267: 14x11
#1352 @ 377,58: 11x19
#1353 @ 547,851: 28x15
#1354 @ 13,901: 13x12
#1355 @ 529,362: 18x29
#1356 @ 196,275: 27x24
#1357 @ 794,955: 13x13
#1358 @ 218,557: 13x17
#1359 @ 536,536: 15x23
#1360 @ 68,86: 25x26
#1361 @ 242,399: 21x19
#1362 @ 618,691: 19x19
#1363 @ 247,227: 29x29
#1364 @ 796,5: 18x16
#1365 @ 335,522: 20x11
#1366 @ 670,654: 23x25
#1367 @ 457,87: 11x25
#1368 @ 932,750: 28x23
#1369 @ 494,15: 14x12
#1370 @ 894,60: 23x12
#1371 @ 781,446: 12x14
#1372 @ 506,132: 27x28
#1373 @ 119,718: 26x15
#1374 @ 65,109: 14x10
#1375 @ 66,773: 26x14
#1376 @ 655,246: 21x26
#1377 @ 325,768: 13x14
#1378 @ 556,691: 7x4
#1379 @ 859,220: 27x13
#1380 @ 435,542: 28x23
#1381 @ 101,16: 16x23
#1382 @ 928,190: 10x19
#1383 @ 57,970: 21x16
#1384 @ 553,927: 22x23
#1385 @ 687,507: 19x27
#1386 @ 604,534: 28x27
#1387 @ 751,652: 15x26
#1388 @ 448,853: 18x15
#1389 @ 539,22: 26x20
#1390 @ 190,458: 15x11
#1391 @ 44,255: 20x11
#1392 @ 74,776: 19x22
#1393 @ 142,815: 25x14
#1394 @ 888,234: 14x14
#1395 @ 734,174: 28x26
#1396 @ 217,293: 27x23
#1397 @ 11,400: 23x27
#1398 @ 122,624: 23x25
#1399 @ 269,668: 22x11
#1400 @ 175,918: 10x5
#1401 @ 348,667: 16x21
#1402 @ 41,383: 22x18
#1403 @ 633,766: 26x10
#1404 @ 673,176: 29x27
#1405 @ 974,461: 14x19
#1406 @ 331,565: 23x12
#1407 @ 600,437: 13x26
#1408 @ 348,24: 16x28
#1409 @ 587,561: 23x23
#1410 @ 766,114: 15x10
#1411 @ 877,70: 27x17
