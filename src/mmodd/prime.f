c      Copyright (C) 2012 - Thierry Clopeau
c 
c     This file must be used under the term of the CeCILL
c      http://www.cecill.info 
      subroutine prime(k,outprime)
!     
      implicit none
!     
      integer nprime,outprime
      parameter (nprime = 250)
!
      integer k,l,m,u
      integer primes( nprime )
!
      DATA primes/251,887,1609,2383,3209,4013,4889,5737,6607,7529,
     & 8429,9323,10223,11173,12149,13043,14011,14983,15907,16937,
     & 17921,18919,19937,20929,21871,22871,23869,24919,25939,26927,
     & 27983,29009,30097,31147,32191,33161,34211,35227,36313,37339,
     & 38447,39461,40583,41621,42589,43717,44777,45893,47051,48109, 
     & 49171,50207,51349,52387,53507,54577,55711,56747,57787,58909,
     & 59957,61099,62213,63397,64513,65617,66751,67801,68993,70177,
     & 71257,72271,73459,74561,75659,76831,77893,79133,80209,81283,
     & 82373,83557,84701,85847,87041,88169,89381,90403,91577,92693,
     & 93851,94951,96013,97213,98453,99571,100747,101869,103001,104231, 
     & 105373,106537,107761,108907,110017,111227,112339,113539,114769,
     & 115879,117109,118249,119513,120661,121697,122869,124067,125221,
     & 126397,127649,128761,129919,131113,132331,133447,134699,135841,
     & 136951,138157,139367,140533,141671,142871,144167,145423,146539,
     & 147727,148957,150067,151243,152381,153523,154769,155887,157217,
     & 158419,159671,160813,162011,163249,164431,165713,166987,168227,
     & 169501,170641,171827,172999,174241,175573,176609,177929,179057,
     & 180179,181537,182657,183907,185089,186187,187387,188693,189851,
     & 191099,192317,193469,194767,195971,197233,198397,199657,200903,
     & 202063,203353,204613,205883,207073,208223,209393,210491,211727, 
     & 213097,214297,215531,216877,218117,219353,220511,221717,222967,
     & 224197,225373,226643,227873,229093,230203,231433,232711,234121,
     & 235243,236659,237977,239171,240371,241601,242789,244121,245279,
     & 246527,247739,248867,250073,251429,252667,253909,255149,256369,
     & 257713,258919,260209,261557,262783,264031,265273,266521,267643,
     & 268909,270143,271351,272549,273943,275183,276371,277657,278903,
     & 280249,281431,282677,284003,285121,286493/
!
      if (k .le. primes(1)) then
         outprime = primes(1)
         return
      else if (k .ge. primes(nprime)) then
         outprime = primes(nprime)
         return
      end if
!     
!  Use binary search to find prime >= K.
!
      l = 1
      u = nprime
   10 continue
      m = (l + u)/2
      if (k .lt. primes(m)) then
         u = m - 1
      else if (k .gt. primes(m)) then
         l = m + 1
      else
         outprime = primes(m)
         return
      endif
      if (l .le. u) goto 10
      outprime = primes(u+1)
      end