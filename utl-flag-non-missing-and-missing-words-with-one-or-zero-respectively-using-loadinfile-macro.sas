%let pgm=utl-flag-non-missing-and-missing-words-with-one-or-zero-respectively-using-loadinfile-macro;

%stop_submission;

Flag non missing and missing words with one or zero respectively using loadinfile macro

   TWO SOLUTIONS
      1 sas loadinfile macro
      2 sas modify and transpose
        PeterClemmensen
        https://communities.sas.com/t5/user/viewprofilepage/user-id/31304

github
https://tinyurl.com/mwepe5e4
https://github.com/rogerjdeangelis/utl-flag-non-missing-and-missing-words-with-one-or-zero-respectively-using-loadinfile-macro

sas communities
https://tinyurl.com/ybrz8fjn
https://communities.sas.com/t5/SAS-Programming/create-flags-on-products-based-on-a-single-column-with-multiple/m-p/956238#M373419

/**************************************************************************************************************************/
/*                                        |                                                |                              */
/*        INPUT                           |           PROCESS                              |       OUTPUT                 */
/*        =====                           |           =======                              |       ======                 */
/*                                        |                                                |                              */
/*  ID    BASKET                          | 1 SAS LOADINFILE MACRO                         |                              */
/*                                        | ======================                         |                              */
/*   1    Product1 / Product2 / Product3  |                                                |                              */
/*   2    Product1                        | MODIFY THE STRING BASKET TO                    |  WANT                        */
/*   3    Product1 / Product2             | MAKE THE STRING EASY FOR                       |         P    P    P          */
/*                                        | INFILE INPUT STATEMENT                         |         R    R    R          */
/*                                        |                                                |         O    O    O          */
/*   data have;                           | data want;                                     |         D    D    D          */
/*      input id basket $ 3-35;           |   length basket $44;                           |         U    U    U          */
/*   datalines;                           |   set have;                                    |         C    C    C          */
/*   1 Product1 / Product2 / Product3     |   informat p1-p3 $8.;                          |    I    T    T    T          */
/*   2 Product1                           |   select (length(strip(basket)));              |    D    1    2    3          */
/*   3 Product1 / Product2                |    when (8)  basket=catx(' ',basket,'.','.');  |                              */
/*   ;;;;                                 |    when (19) basket=catx(' '                   |    1    1    1    1          */
/*   run;quit;                            |         ,compress(basket,'/')                  |    2    1    0    0          */
/*                                        |         ,'.');                                 |    3    1    1    0          */
/*                                        |    when (30) basket=compress(basket,'/');      |                              */
/*                                        |   end;                                         |                              */
/*                                        |   /*                                           |                              */
/*                                        |   Basket                                       |                              */
/*                                        |   Product1 Product2  Product3                  |                              */
/*                                        |   Product1 . .                                 |                              */
/*                                        |   Product1 Product2 .                          |                              */
/*                                        |   */                                           |                              */
/*                                        |   put basket;                                  |                              */
/*                                        |   %loadinfile(basket);                         |                              */
/*                                        |   input p1-p3 & @;                             |                              */
/*                                        |   product1=1-cmiss(p1);                        |                              */
/*                                        |   product2=1-cmiss(p2);                        |                              */
/*                                        |   product3=1-cmiss(p3);                        |                              */
/*                                        |   id =_n_;                                     |                              */
/*                                        |   input @1 @@;                                 |                              */
/*                                        |   keep id product:;                            |                              */
/*                                        | run;quit;                                      |                              */
/*                                        |                                                |                              */
/*                                        |                                                |                              */
/*                                        |                                                |                              */
/*                                        | 2 SAS MODIFY AND TRANSPOSE                     |                              */
/*                                        | ==========================                     |                              */
/*                                        |                                                |                              */
/*                                        | data temp(keep = id w d);                      |                              */
/*                                        |    set have;                                   |                              */
/*                                        |    do c = 1 to countw(basket);                 |                              */
/*                                        |       w = scan(basket, c, ' /');               |                              */
/*                                        |       d = 1;                                   |                              */
/*                                        |       output;                                  |                              */
/*                                        |    end;                                        |                              */
/*                                        | run;                                           |                              */
/*                                        |                                                |                              */
/*                                        | proc transpose data=temp out=tmp(drop = _:);   |                              */
/*                                        |    by id;                                      |                              */
/*                                        |    id w;                                       |                              */
/*                                        |    var d;                                      |                              */
/*                                        | run;                                           |                              */
/*                                        |                                                |                              */
/*                                        | data want;                                     |                              */
/*                                        |   set tmp(rename=(product1-product3=p1-p3));   |                              */
/*                                        |   product1=1-cmiss(p1);                        |                              */
/*                                        |   product2=1-cmiss(p2);                        |                              */
/*                                        |   product3=1-cmiss(p3);                        |                              */
/*                                        |   keep id product1-product3;                   |                              */
/*                                        | run;quit;                                      |                              */
/*                                        |                                                |                              */
/**************************************************************************************************************************/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
