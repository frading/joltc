rm -rf WASM_Release && \
export CC=/usr/bin/clang CXX=/usr/bin/clang++ && \
./cmake_linux_emscripten.sh Release && \
cd WASM_Release && \
make -j 24 && \
cp lib/* /home/gui/work/web/games/simple_physics_lib_for_jai_and_wasm/modules/jolt/wasm/