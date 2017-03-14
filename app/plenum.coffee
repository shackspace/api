moment = require 'moment'
require 'moment/locale/de'

module.exports.next = () ->
	plenumForWeek = (start) ->
		if start.week() % 2 is 0
			start.day('Donnerstag')
		else
			start.day('Mittwoch')
	plenumDate = moment().startOf('week')
	plenumForWeek plenumDate
	if moment().isAfter(plenumDate, 'day')
		plenumDate.day(8)
		plenumForWeek plenumDate

	plenumDate.set('hour', 20)
	return plenumDate
