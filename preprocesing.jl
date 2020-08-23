using Queryverse
using Statistics
using ElectronDisplay

function emptySTRtoMissing(string)
    if string == ""
        return missing
    else
        return string
    end
end

wines = load("winemag-data_first150k.csv") |> DataFrame

meanPrice = mean(skipmissing(wines.price))

wines = wines |> @select(-1) |> @mutate(region_2 = emptySTRtoMissing(_.region_2)) |> DataFrame

winesClean = wines |> @replacena(:country => "Not especified", :description => "Not especified", :designation => "Not especified", 
:price => :($meanPrice), :province => "Not especified", :region_1 => "Not especified", :region_2 => "Not especified", 
:variety => "Not especified", :winery => "Not especified") |> DataFrame

winesClean |> save("winesClean.csv")


"""
df = DataFrame(a=[1,2,missing], b=["One","","Three"])

df |> @mutate(b = emptySTRtoMissing(_.b))

myMean = mean(skipmissing(df.a))

df |> @mutate(c = myMean)

q = df |> @replacena(:b=>"Unknown", :a => :($myMean) ) |> DataFrame

df |> @dropna()"""