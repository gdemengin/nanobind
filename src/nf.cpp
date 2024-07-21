#include <nanobind/nanobind.h>

namespace nb = nanobind;

struct MyStruct {
  nb::object m_field;

  MyStruct() : m_field(nb::none()) {}
};

NB_MODULE(nf, m) {

  nb::class_<MyStruct>(m, "MyStruct")
      .def(nb::init<>())
      //.def_rw("m_field", &MyStruct::m_field);
      .def_prop_rw(
          "m_field",
          [](MyStruct& t) {
            if (t.m_field.is_none()) {
              return nb::none();
            } else {
              return t.m_field;
            }
          },
          [](MyStruct& t, nb::object value) { 
              t.m_field = value; 
          },
          nb::arg("value") = nb::none()
      );
}
