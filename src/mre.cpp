#include <malloc.h>
#include <string.h>
#include <nanobind/nanobind.h>
#include <nanobind/ndarray.h>

namespace nb = nanobind;

static nb::object reproduce(nb::ndarray<nb::numpy, uint8_t, nb::ro, nb::ndim<1>, nb::device::cpu, nb::c_contig>& buffer) { return nb::none(); }

NB_MODULE(mre, m) {
    m.def("reproduce", &reproduce);
}
