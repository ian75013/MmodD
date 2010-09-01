 SUBROUTINE amuxd(n,x,y,diag,ndiag,idiag,ioff) 
      IMPLICIT NONE
c     ---------------------------------------
c     DECLARATION DES VARIABLES DES ARGUMENTS
c     ---------------------------------------
      INTEGER n, ndiag, idiag, ioff(idiag) 
      DOUBLE PRECISION x(n), y(n), diag(ndiag,idiag)
c     ---------------------------------
c     DECLARATION DES VARIABLES LOCALES
c     ---------------------------------
      INTEGER j, k, io, i1, i2 
c     +----------------------------------------------------------------+
c      IF (debug.eq.1) CALL wdebg('AMUXD',1)
c     +----------------------------------------------------------------+
      do j=1,n
        y(j)=0.0d0
      enddo 
c	
      do j=1,idiag
        io=ioff(j)
        i1=max0(1,1-io)
        i2=min0(n,n-io)
        do k=i1,i2	
          y(k)=y(k)+diag(k,j)*x(k+io)
        enddo
      enddo
c     +----------------------------------------------------------------+
c      IF (debug.eq.1) CALL wdebg('AMUXD',2)
c     +----------------------------------------------------------------+
      return
      end