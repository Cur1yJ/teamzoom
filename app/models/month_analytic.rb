###########################################################################
# Change History
###########################################################################
# Date-02/01/2013
# Coder- Shrikant Khandare
# Description: Added comment at beginning of class describing what is this for.
############################################################################

# google analytics for pageviews and statistic .It gives pageviews for month.

class MonthAnalytic

   extend Garb::Model
   metrics :pageviews
   dimensions :month
   
end
