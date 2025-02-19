const Lconst = require('./jops');

test('simple check, initiate without anything', () => {
  const testing = new Lconst();
  expect(testing.explicit_str).toBe(false);
  expect(testing.bits).toBe(0n);
  expect(testing.num).toBe(0n);
});

test('simple check, if it is a number', () => {
  const testing = new Lconst(3n);
  expect(testing.num).toBe(3n);
  expect(testing.bits).toBe(3n);
  expect(testing.explicit_str).toBe(false);
});

test('simple check, if it is not a number', () => {
  const testing = new Lconst('3');
  expect(testing.num).toBe(0n);
  expect(testing.bits).toBe(0n);
  expect(testing.explicit_str).toBe(false);
});

test('complicated check, if it is a large positve number', () => {
  const testing = new Lconst(123456789101112131415n);
  expect(testing.num).toBe(123456789101112131415n);
  expect(testing.bits).toBe(68n);
  expect(testing.explicit_str).toBe(false);
});

// negative number looks no correct, reason: signed integer
test('complicated check, if it is a large negative number', () => {
  const testing = new Lconst(-123456789101112131415n);
  expect(testing.num).toBe(-123456789101112131415n);
  expect(testing.bits).toBe(68n);
  expect(testing.explicit_str).toBe(false);
});
