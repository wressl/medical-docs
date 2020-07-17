class FRS
  @@RiskPoints = [
    # Male Risk Points
    [
      [0,2,5,7,8,10,11,12,14,15], # age points
      [-2,-1,0,1,2],              # hdl-c points
      [0,1,2,3,4],                # total cholesterol point
      [-2,0,1,2,2,3],             # blood pressure not treated
      [0,2,3,4,4,5],              # blood pressure treated
      [0,4]                       # smoking
    ],
    # Female Risk Points
    [
      [0,2,4,5,7,8,9,10,11,12],   # age points
      [-2,-1,0,1,2],              # hdl-c points
      [0,1,3,4,5],                # total cholesterol point
      [-3,0,1,2,4,5],             # blood pressure not treated
      [-1,2,3,5,6,7],             # blood pressure treated
      [0,3]                       # smoking
    ]
  ]

  @@CVDRisk = [
    [1, 1.1, 1.4, 1.6, 1.9, 2.3, 2.8, 3.3, 3.9, 4.7, 5.6,
     6.7, 7.9, 9.4, 11.2, 13.3, 15.6, 18.4, 21.6, 25.3, 29.4,
     30, 30, 30, 30],
    [1, 1, 1.0, 1.2, 1.5, 1.7, 2.0, 2.4, 2.8, 3.3, 3.9, 4.5,
     5.3, 6.3, 7.3, 8.6, 10.0, 11.7, 13.7, 15.9, 18.5,
     21.5, 24.8, 27.5, 30]
  ]

  @@HeartAge = [
    [30, 32, 34, 36, 38, 40, 42, 45, 48, 51, 54, 57, 60,
     64, 68, 72, 76, 80],
    [30, 31, 34, 36, 39, 42, 45, 48, 51, 55, 59, 64, 68,
     73, 79, 80, 80, 80]
  ]

  def initialize(female, age, hdl, totc, sbp, tx, smoke, diabetes)
    points = 0

    # index into age points
    age_index = [(([age,30].max - 30)/5).floor, 9].min

    points += @@RiskPoints[female][0][age_index]

    # index into hdl points
    if hdl > 1.6
      hdl_index = 0
    elsif hdl >= 1.3
      hdl_index = 1
    elsif hdl >= 1.2
      hdl_index = 2
    elsif hdl >= 0.9
      hdl_index = 3
    else
      hdl_index = 4
    end
    points += @@RiskPoints[female][1][hdl_index]

    # index into total cholesterol points
    if totc > 7.2
      totc_index = 4
    elsif totc >= 6.2
      totc_index = 3
    elsif totc >= 5.2
      totc_index = 2
    elsif totc >= 4.1
      totc_index = 1
    else
      totc_index = 0
    end
    points += @@RiskPoints[female][2][totc_index]

    # index into blood pressure points
    sbp_index = [(([sbp,110].max - 110)/10).floor, 5].min
    points += @@RiskPoints[female][3+tx][sbp_index]

    # add smoking points
    points += @@RiskPoints[female][5][smoke]

    # actually don't use diabetes for points
    # considered CVD equivalent...

    puts "Total Points is #{points}"

    # get the risk
    risk_index = [[points + 3, 0].max, 24].min
    @risk = @@CVDRisk[female][risk_index]
    rover = ""
    if @risk == 30
      rover = "over "
    end

    # get the heart age
    ha_index = [[points,0].max, 17].min
    @heart_age = @@HeartAge[female][ha_index]
    hover = ""
    if @heart_age == 80
      hover = "over "
    end

    puts "CVD Risk is #{rover}#{@risk} % and heart age is #{hover}#{@heart_age} years"
  end
end

#cvdrisk = FRS.new( 1, 30, 1.6, 4.0, 100, 0, 0, 0)
#cvdrisk = FRS.new( 0, 60, 0.9, 6.4, 150, 1, 1, 0)


