clone-px4:
	git clone https://github.com/px4/Firmware.git ../Firmware

list-topics:
	cd ../Firmware/msg  && ls *.msg > ../../msg_list.txt

generate-rtps-topics:
	cd ../Firmware/msg/tools && while read -r file; do \
		echo $$file; \
		python generate_microRTPS_bridge.py -s $$file -t .; \
		done < ../../../msg_list.txt

include-generated-code:
	mkdir -p include/ src/
	cd ../Firmware/msg/src/modules/micrortps_bridge/micrortps_agent && while read -r file; do \
		file=$$(echo $$file | cut -d '.' -f1); \
		echo $$file; \
		header_file=$$file"_.h"; \
		echo $$header_file; \
		src_file=$$file"_.cpp"; \
		cp $$header_file ../../../../../../sample_package/include/ && cp $$src_file ../../../../../../sample_package/src; \
		done < ../../../../../../msg_list.txt

deb-pkg: clone-px4 list-topics generate-rtps-topics include-generated-code
	tar caf ../sample-package_1.0.orig.tar.gz . --exclude debian --exclude Makefile
	dpkg-buildpackage -uc -us

clean:
	rm -rf ../Firmware/
