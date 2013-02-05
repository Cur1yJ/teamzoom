##########################################################################
# Change History
##########################################################################
# Date-02/01/2013
# Coder- Shrikant Khandare
# Description: Added comment at beginning of class describing what is this for.
############################################################################

# google analytics for pageviews and statistic .It gives pageviews for date.

class DateAnalytic

   extend Garb::Model
   metrics :pageviews
   dimensions :date

end
