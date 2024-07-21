import nf

def test_none_field():
    t1 = nf.MyStruct()
    t1.m_field = None

    t2 = nf.MyStruct()
    t2.m_field = { 'x': 5, 'y': 3 }

    t3 = nf.MyStruct()

    t4 = nf.MyStruct()
    t4.m_field = { 'x': 5, 'y': 3 }

    t5 = nf.MyStruct()
    t5.m_field = 5

    print('t1.m_field=', t1.m_field)
    print('t2.m_field=', t2.m_field)
    print('t3.m_field=', t3.m_field)
    print('t4.m_field=', t4.m_field)
    print('t5.m_field=', t5.m_field)
    
    assert t1.m_field == None
    assert t1.m_field is None

    assert t2.m_field != None

    assert t2.m_field is not None
    assert t2.m_field == { 'x': 5, 'y': 3 }
    
    assert t3.m_field == None
    assert t3.m_field is None

    assert t4.m_field is not None
    assert t4.m_field == { 'x': 5, 'y': 3 }

    assert t5.m_field is not None
    assert t5.m_field == 5

    assert t1.m_field != t2.m_field
    assert t1.m_field == t3.m_field
    assert t2.m_field == t4.m_field
    assert t5.m_field != t1.m_field
    assert t1.m_field != t5.m_field

test_none_field()
