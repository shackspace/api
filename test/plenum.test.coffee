moment = require 'moment'
chai = require 'chai'
expect = chai.expect

plenum = require '../app/plenum'

describe 'plenum dates', ->
	it 'should produce a date', ->
		expect(plenum.next().isValid()).true
	
	it 'should be Wednesday on Monday, Week 11', ->
		moment.now = -> +(new Date('2017-03-13'))
		expect(plenum.next().isSame('2017-03-15', 'day')).true
	
	it 'should be Wednesday on Wednesday, Week 11', ->
		moment.now = -> +(new Date('2017-03-15'))
		expect(plenum.next().isSame('2017-03-15', 'day')).true
	
	it 'should be not Thursday on Monday, Week 11', ->
		moment.now = -> +(new Date('2017-03-13'))
		expect(plenum.next().isSame('2017-03-16', 'day')).false
		
	it 'should be Thursday on Monday, Week 12', ->
		moment.now = -> +(new Date('2017-03-20'))
		expect(plenum.next().isSame('2017-03-23', 'day')).true
	
	it 'should be Thursday on Thursday, Week 12', ->
		moment.now = -> +(new Date('2017-03-23'))
		expect(plenum.next().isSame('2017-03-23', 'day')).true
		
	it 'should be Wednesday on Saturday, Week 10', ->
		moment.now = -> +(new Date('2017-03-11'))
		expect(plenum.next().isSame('2017-03-15', 'day')).true
	
	it 'should be Thursday on Thursday, Week 11', ->
		moment.now = -> +(new Date('2017-03-16'))
		expect(plenum.next().isSame('2017-03-23', 'day')).true
