cmake_minimum_required(VERSION 2.8.3)
project(sample_package)

add_compile_options(-std=c++11)

find_package(catkin REQUIRED)
find_package(fastrtps REQUIRED)
find_package(fastcdr REQUIRED)

catkin_package(
#  INCLUDE_DIRS include
#  LIBRARIES sample_package
#  CATKIN_DEPENDS other_catkin_pkg
#  DEPENDS system_lib
)

include_directories(
  include
)

add_library(sample_package
  src/home_position_.cpp
  src/sensor_combined_.cpp
)

target_link_libraries(sample_package
  fastrtps
  fastcdr
)

install(DIRECTORY include/
  DESTINATION /usr/share/sample-package/include/
)

install(TARGETS sample_package sample_package
  LIBRARY DESTINATION /usr/share/sample-package/lib/
)
