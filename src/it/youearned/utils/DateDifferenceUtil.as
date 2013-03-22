package it.youearned.utils
{
	public final class DateDifferenceUtil
	{
		
		/**
		 * This is specific to the YouEarnedIt difference... so it will round differences to minues, hours or days. 
		 * @param dateA Later Date
		 * @param date2 Earlier Date
		 * @return 
		 * 
		 */
		public static function difference(dateA:Date, date2:Date):String
		{
			var text:String = "";
			
			//trace("thenDate: ", date2.toString());
			var adjuestedDateTime:Date = new Date(date2.toLocaleString());
			var newDate:Date = new Date();
			//trace("nowDate: ", newDate.toString());
			//date2.setTime(date2.getTime() + (date2.getTimezoneOffset() / 60000))
			
			date2.minutes -= newDate.getTimezoneOffset(); 
			
			//trace("thenDate: ", date2.toString());
			//trace("nowDate: ", newDate.toString());
			var ts:TimeSpan = TimeSpan.fromDates(date2,newDate);
			var days:Number = ts.totalDays;
			if (days < 1) {
				var hours:Number = Math.round(ts.totalHours);
				if (hours < 1) {
					var minutes:Number = Math.round(ts.totalMinutes);
					if (minutes < 1) {
						text = "Less than 1 minute ago";
					}
					else {
						text = minutes + " minutes ago";
					}
				}
				else {
					text = hours + " hours ago";
				}
			}
			else {
				if (days > 7) {
					var weeks:Number = Math.round(days / 7);
					if (weeks > 4) {
						var months:Number = Math.round(days/30);
						if (months >= 12) {
							var years:Number = Math.round(days/365);
							if (years >= 1) {
								text = "Over a year ago";
							}
							else {
								text = "A year ago";
							}
						}
						else {
							if (months == 1) {
								text = "1 month ago";
							}
							else {
								text = months + " months ago";
							}
						}
					}
					else {
						text = Math.round(days / 7) + " weeks ago";
					}
				}
				else {
					text = Math.round(days) + " days ago";
				}				
			}
			
			return text;
		}
		
	}
}