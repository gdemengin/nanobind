minimum reproducer environment for leak with nb 2.0.0 + check the fix removes the leak

```
docker build -t ndarray-leak-mre .
docker run -v $(pwd):/mnt/docker -itd --rm --name ndarray-leak-mre ndarray-leak-mre
docker exec -it ndarray-leak-mre /bin/bash
cd /mnt/docker
./reproduce.sh
```

result:
```
+ diff nb2.0.0.log nb2.0.0+ndarray-leak.patch.log
1,15d0
<
< =================================================================
< ==194==ERROR: LeakSanitizer: detected memory leaks
<
< Direct leak of 80 byte(s) in 1 object(s) allocated from:
<     #0 0x7fc80b91f61f in malloc (/lib64/libasan.so.8+0xdd61f) (BuildId: 1d5b30c36844ba264ef3e2de667e7a3b01c75e84)
<     #1 0x7fc80b236848 in PyMem_Malloc (/lib64/libpython3.11.so.1.0+0x1dd848) (BuildId: 1c275add58b260eaed423bcf6f89cf5b753a0389)
<     #2 0x7fc8095b2117  (/mnt/docker/.venv/lib64/python3.11/site-packages/mre.cpython-311-x86_64-linux-gnu.so+0x53117) (BuildId: 453c323ff2f76c062da0865a220d35eb8a5b7614)
<     #3 0x7fc8095b4430  (/mnt/docker/.venv/lib64/python3.11/site-packages/mre.cpython-311-x86_64-linux-gnu.so+0x55430) (BuildId: 453c323ff2f76c062da0865a220d35eb8a5b7614)
<     #4 0x7fc8095793d9  (/mnt/docker/.venv/lib64/python3.11/site-packages/mre.cpython-311-x86_64-linux-gnu.so+0x1a3d9) (BuildId: 453c323ff2f76c062da0865a220d35eb8a5b7614)
<     #5 0x7fc809578a85  (/mnt/docker/.venv/lib64/python3.11/site-packages/mre.cpython-311-x86_64-linux-gnu.so+0x19a85) (BuildId: 453c323ff2f76c062da0865a220d35eb8a5b7614)
<     #6 0x7fc809578ffb  (/mnt/docker/.venv/lib64/python3.11/site-packages/mre.cpython-311-x86_64-linux-gnu.so+0x19ffb) (BuildId: 453c323ff2f76c062da0865a220d35eb8a5b7614)
<     #7 0x7fc809589b43  (/mnt/docker/.venv/lib64/python3.11/site-packages/mre.cpython-311-x86_64-linux-gnu.so+0x2ab43) (BuildId: 453c323ff2f76c062da0865a220d35eb8a5b7614)
<     #8 0x7fc80b295712 in PyObject_Vectorcall (/lib64/libpython3.11.so.1.0+0x23c712) (BuildId: 1c275add58b260eaed423bcf6f89cf5b753a0389)
<
22d6
< SUMMARY: AddressSanitizer: 80 byte(s) leaked in 1 allocation(s).
```
