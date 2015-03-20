#########################################################################################
#DESCRIPTION:                                                                           #
#Filename: eavg.gnu   	                                                                #
#gnuplot script file for plotting data in files 'eavg.data' and 'cv.data'              	#
#Taken from YouTube user hexafoil's video "Modern Fortran by Example (9) Gnuplot Part 3"#
#and from http://people.duke.edu/~hpgavin/gnuplot.html                                  #
#This sets the styles for gnuplot when called on in 'statmechproblem.f95' to   	        #
#plot the data. Graph of plots saved as 'eavg.jpg' and 'cv.jpg'.                        #
#ORIGIN INFO:                                                                           #
#Code written in gedit 					                                #
#Author: Michael Conroy                                                                 #
#Contact: sietekk@gmail.com                                                             #
#########################################################################################

# <E> DATA
set terminal jpeg transparent enhanced font "arial,10" fontscale 1.0 size 1024, 768
set output 'eavg.jpg'
set title '<E> vs T for N-state Problem'
set xlabel 'Temperature (K)'
set ylabel '<E> Average Energy'
#set xrange [0:100]
set grid
set key off
plot "/media/hdd/SCSU\ Fall\ 2013/PHY\ 499/Stat\ Mech\ Programming\ Problem/eavg.data" using 1:2 with linespoints ls 6 lc 7

# C_v DATA
set terminal jpeg transparent enhanced font "arial,10" fontscale 1.0 size 1024, 768
set output 'cv.jpg'
set title 'C_v vs T for N-state Problem'
set xlabel 'Temperature (K)'
set ylabel 'C_v Heat Capacity'
#set xrange [0:100]
set grid
set key off
plot "/media/hdd/SCSU\ Fall\ 2013/PHY\ 499/Stat\ Mech\ Programming\ Problem/cv.data" using 1:2 with linespoints ls 6 lc 7
