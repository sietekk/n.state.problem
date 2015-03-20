!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! DESCRIPTION:                                                     !
! 'statmechprob' is a program that solves for a canonical ensemble !
! N-state problem. Specifically, it solves for <E> and C_v both as !
! functions of T for a single site, one body, 3-state three-state, !
! problem. The user enters any three energy values with the        !
! condition that <E> and C_v are >= zero. The program then creates !
! two arrays over a predetermined temperature range. These arrays  !
! will then be used to plot <E>(T) and C_v(T).                     !
!								   !
! AUTHOR INFO:                                                     !
! Author: Michael Conroy                                           !
! Email: sietekk@gmail.com                                         !
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

program statmechprob
implicit none

!DECLARE VARIABLES
real :: E0, E1, E2 !Energy level values
real :: Tmax, Tmin !Max and min temperatures for Tarray
real :: dT !Interval change in temperature
real :: Z, Zderiv1, Zderiv2 !Partition function Z and its first and second derivatives (Z' and Z")
real :: beta !Inverse temperature; k_b = 1
integer, parameter :: n=1000 !Number of values to populate Tarray
real, dimension(n):: Tarray !Temp values across 'n' intervals
real, dimension(2,n) :: EavgData !Holds <E>(T) data
real, dimension(2,n) :: CvData !Holds C_v(T) data
integer :: i, j, k, l, m, nn !Indices for implicit and reg do loops for array assignments


!DATA ENTRY AND CREATION
!Entry
print *, 'Enter Tmin and then Tmax seperated by a comma or space: '
read *, Tmin, Tmax
print *, 'Enter E0, E1, and then E2 seperated by a comma or space: '
read *, E0, E1, E2
!Calculaton and array population
dT = (Tmax - Tmin)/(n)
print *, 'The temperature interval dT is: ', dT
Tarray(:) = (/( i*dT+Tmin, i=1,n )/)
print *, 'The temperature array Tarray is: ', Tarray
EavgData(1,:) = (/ (Tarray(j), j=1,n) /)
CvData(1,:) = (/ (Tarray(k), k=1,n) /)

!CALCULATE <E> AND C_v VALUES
do l = 1,n
	beta = 1.0 / Tarray(l) !Remember, k_b = 1 here
	Z = exp(-beta*E0) + exp(-beta*E1) + exp(-beta*E2)
	Zderiv1 = -( E0*exp(-beta*E0) + E1*exp(-beta*E1) + E2*exp(-beta*E2) )
	Zderiv2 = (E0**2.)*exp(-beta*E0) + (E1**2.)*exp(-beta*E1) + (E2**2.)*exp(-beta*E2)
	EavgData(2,l) = -(Zderiv1 / Z)
	CvData(2,l) = (1 / Tarray(l)**2) * ((Zderiv2 / Z) - (Zderiv1 / Z)**2.)
end do

!OUTPUT DATA TO SCREEN
!print *, 'Outputing <E> besides C_v now...'
!print *, EavgData
!print *, CvData

!SAVE DATA
!<E> data will be saved to its own file first
open(unit=99,file='eavg.data',status='replace')
	do m=1,n
		write(99,*) EavgData(1,m), ' ', EavgData(2,m)
	end do
close(unit=99)
print *, '<E> data has been saved!'

!C_v data will be saved to its own file first
open(unit=99,file='cv.data',status='replace')
	do nn=1,n
		write(99,*) CvData(1,nn), ' ', CvData(2,nn)
	end do
close(unit=99)
print *, 'C_v data has been saved!'

!GRAPH DATA
call system('gnuplot statmechprob.gnu')

!END OF PROGRAM
end program statmechprob



