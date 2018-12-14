require './lib/solver'

class Solver
  def call(lines, times = [2, 3])
    exactly_count_lists = make_count_list times

    lines.each do |line|
      counts = {}

      line.chars.each { |a| counts[a] = counts.fetch(a, 0) + 1 }

      line_counts = make_count_list times

      counts.each do |letter, count|
        line_counts[count] << letter if line_counts[count]
      end

      exactly_count_lists.reject do |count, _|
        line_counts[count].count == 0
      end.each { |count, list| list << line_counts[count][0] }
    end

    exactly_count_lists[2].count * exactly_count_lists[3].count
  end

  private

  def make_count_list(times)
    Hash[times.map { |t| [t, []] }]
  end
end

lines = ['abcdef', 'bababc', 'abbcde', 'abcccd', 'aabcdd', 'abcdee', 'ababab']

assert Solver.new.call(lines), 12

lines = DATA.each_line.map(&:strip).reject(&:empty?) #

assert(lines.first, 'asgwdcmbrkerohqoutfylvzpnx')
assert(lines.last, 'asgwjcmxrkedihqoutfyivzpmx')

puts Solver.new.call(lines)

__END__
asgwdcmbrkerohqoutfylvzpnx
asgwjcmbrkejihqoutfylvipne
asgwjcmbrkedihqoutvylizpnz
azgsjcmbrkedihqouifylvzpnx
asgwucmbrktddhqoutfylvzpnx
asgwocmbrkedihqoutfylvzivx
aqgwjcmbrkevihqvutfylvzpnx
tsgljcmbrkedihqourfylvzpnx
asgpjcmbrkedihqoutfnlvzsnx
astwjcmbrktdihqrutfylvzpnx
asgwjcmbrpedhhqoutfylvzynx
xsgwjcmbrkedieqowtfylvzpnx
asgwjcmbvkedihfoutnylvzpnx
asgwjcmtrkedihqouafylvzcnx
asgwjcmbrkedihqoutfylvxpvm
usgwjcmbrkedihqortfyuvzpnx
asgwjcmbrwedihqoutfylizpix
asgrjcvbrkedixqoutfylvzpnx
asgwjcmbrogdihqoutfelvzpnx
aggwjcmbrkesihqoutoylvzpnx
asgtjccbrkedihqoutfrlvzpnx
asgcucmbrbedihqoutfylvzpnx
esgwjcmbrkedihqsutfylvzcnx
asgwjcmbrkedrhqoutfyobzpnx
mngwjcbbrkedihqoutfylvzpnx
asgwjcrbrkeoihqyutfylvzpnx
apgwjcmbrkednhqogtfylvzpnx
asgwjcwbrkedihqoutfylplpnx
asgwjcmbrkfdihqoutfxlvzpyx
aegwjcmbrkedihqoutfylbxpnx
asgljcmbrkedixqoutaylvzpnx
aigwjcmbrkedihqouhfylvzpex
asgwjbmbrkedihqoutfylfzpnp
asgwjcmzroedihqoutcylvzinx
asgwjcwbrieuihqoutfylvzpnx
aagwjcmbrkedjhqdutfylvzpnx
ahgwjcmbrkedihqsutfylvzpfx
asgwjcmbrkedihzosttylvzpnx
aegwjcmbrkedioqnutfylvzpnx
asgwjcmbykidihqoutfysvzpnx
asgwkcxbrkeddhqoutfylvzpnx
ashwjcmbrkeeihqoutfylvzknx
acgwjcmbrqedihqoqtfylvzpnx
asgwjcmtrkedihooutfylszpnx
asgwjcmbrkmdihqfutrylvzpnx
asgwjcmbrkedihqoutjylvapnn
asgwjcmbwkedihqoutkylkzpnx
asgwjrmbrkedihqoutfycnzpnx
asgwtcmbrkedihqoqtfylozpnx
asgajcmbrkedihqoutuylvzpny
asgwjcmbykedihqoutfylfzpwx
asgwjcsbrkedihpoutfylvvpnx
hsdwjcmbrvedihqoutfylvzpnx
asgwjcmbrkedihqoutfdmszpnx
adgwjcmbrtidihqoutfylvzpnx
augwjcmbriedihqoutgylvzpnx
asgwjvmbreedihqoutfllvzpnx
asgwjcnbfkedihqoltfylvzpnx
asgwjcmbykddihqoutqylvzpnx
ajgwjcmbrkedihqoutfylvpvnx
asgwjcmbrkydihqoutfylszpnl
xsgwjcmbrkqdihqoutfylvkpnx
asgwjcmbrkedimqoutfklvzknx
csgwjbmbrkedihqoftfylvzpnx
asgwjcmbjkedihjoutfylvzpnn
asgwjcmprkedihqoulfalvzpnx
asgwjcmbrvediqqoutfyuvzpnx
asgwjambrkedhhqoutkylvzpnx
asgejcmbrkidihqoutfylvzpnk
hsiwjcmbrkedihqoutfylvzpnq
asswjczbrkedihqoutfylczpnx
asgwjnmbrkedyhzoutfylvzpnx
asgwscmbrkedihqoutfklvlpnx
asgwlcmbrktdihqoutfylvzpax
asfwjcmerkedihqoutfylvipnx
asgwjcmbrkeditqoeafylvzpnx
asgwgcmbrkesihqoutfylyzpnx
fsgwjcmbrkedihqouvfyavzpnx
asgwjcmbrpedwhqoutfylmzpnx
asgwjcmbrkzdzhqoucfylvzpnx
asgwjcmnrketmhqoutfylvzpnx
asgwjcmbrkedihxoutsylvzpnh
asgwjcobrkedihqoutfrlvzpox
asgwjcmbrkedihqootfylxzpox
asgjjcmcrkedihqoutfylmzpnx
lsgwjcmbrkedihqoutfyqvzunx
asgwjcmbrwedihqoutoylvzpnu
aszwjcmbtkedihqoutfylczpnx
asgwjcmbykedihqoutfylvgpex
asgijcmbrkedilqoutkylvzpnx
astwxcmzrkedihqoutfylvzpnx
akgwjcmbnkedihqfutfylvzpnx
asgwjcmbrqndivqoutfylvzpnx
asgwjrmbrleqihqoutfylvzpnx
asgwjcmbrkevihqoutfxlvzpvx
asbwjcmbrkedihqoutfelvwpnx
asewjcbbrkmdihqoutfylvzpnx
asgwjcmbrkeaihxoutfylpzpnx
asgwjzmbrkedihqrotfylvzpnx
asgwjcmbrkedihqoutgdxvzpnx
asgwjcwbrkmdihqoutfylvzlnx
asgwjcmbrkegihqoutfylrzpax
ajgwjcmbrkegihqhutfylvzpnx
asgwjcmbrzedihqhutfylvkpnx
asgwjcmwrkedihqouhfylkzpnx
aygwjcmbrkedihqoutfdlvzpnr
asgwjcmbrkednhqoutiylvypnx
aqgwjcmbrkezihqoutfylvzonx
bsgwjcmbrkedihqouhfylvzsnx
asgwjcmcrkedihqokyfylvzpnx
asgsjcmbrkewiyqoutfylvzpnx
asgwpcmbrkejihqoutfylzzpnx
asgwjumbrkedbeqoutfylvzpnx
asgwjcmbrkedihpoutqylqzpnx
awgwjcmbrredihqoutfylvzpna
asgwjsmbraedihqoutfylvzpvx
asgwncmbrkedihqoutfyljzrnx
asgwncmbrkedihqohtfylvzonx
asgwjcmbrkedihqlutfylvypux
asgwjcmbbkedihooutfylkzpnx
asghjcmsryedihqoutfylvzpnx
asgwjcmbrkevihqoulfzlvzpnx
asggjcmbrkedizqoutfylvzknx
asbwjcmbriedihqoutfylvmpnx
asgwjcmbrkedqbqoutfylvzenx
asgwjcmprkedihqoutfylvzknp
asgwjcmbrkerihqoutfwlvzpno
asgwjcmvrkesihqoutrylvzpnx
asgzjcmbrkedihqoutfnlvbpnx
asfwjcmbrkhdihqoutfylpzpnx
asgwjcmbskedihqdutfyyvzpnx
asgwjcmzrkedihqoutcylvzinx
asgwjcmbrkedibqoutfylvjonx
asgwjcmbrbedihqoutfylmzbnx
asgwjcmbrkedhhqoutmylczpnx
asgwjcmbrkbgihqoutzylvzpnx
asgwjcfbrkedihqoupfyxvzpnx
asiwjcmbzkedihqoutfyluzpnx
asvwjcmbrkedihqoitfylvzpns
asgwjcmxikedihqoutfyevzpnx
asgwjcmbrkedioqoutfylvzwox
asgwjcmbrkedivqoutjyuvzpnx
asgwjcmbkkydihqrutfylvzpnx
asgwjcmbrkxdiuqoutfylvopnx
asgwjcmbrkedihqouthylvzpra
asgwjcmbrzedimloutfylvzpnx
asgwjcmbrkedmhqoulfytvzpnx
asgwjcmbrkzdihqrutfysvzpnx
ssgwjcmxrkedihqoutftlvzpnx
asgwjcmbrkedihqoutfajvzynx
asgwjcmbrkqdihqxuufylvzpnx
asmwjcabrkedihqouxfylvzpnx
asgwjcmbrkeeihqoatfycvzpnx
asgwjcjbrgedjhqoutfylvzpnx
asgljcmtrkedihqoutoylvzpnx
asgwjcmbrkedigqouzfylvzpvx
ajgvjcmbkkedihqoutfylvzpnx
asgwjcmbrkedihqtugfygvzpnx
asgbjcmbrkedihboftfylvzpnx
asgwjwmbrkedihqontfylhzpnx
asgwjfmhrkedihqoutfylvqpnx
asgwjxmbrkedihqoutzylvzpnj
asgwjcrlrkedihqoutfylvzpsx
aygwjcmbrkedihqoutsylvzdnx
zsgwjcmbrkedihjogtfylvzpnx
asgwjxmbrkegihqoutfylvopnx
asgwjcmbrkedihqhutfylvzcnr
asgwicmbrkewihvoutfylvzpnx
asqwjcmbvkedihqoutfylvzknx
asgwjcmbrkedihqoktfyevzpnu
asgwjcmbrkudihqoutfylqzznx
asgwjdmbrkedihqoutfylvvdnx
asgwjcmbrkwmihqautfylvzpnx
asgwjcmbrxedihqoctfyldzpnx
asgwjdmbrkedjhqoutfyfvzpnx
asgwjcmtrzedihqoutfylvzpnm
bpgwjcmbrmedihqoutfylvzpnx
asgwjctbrkedihqoqtfynvzpnx
askhjcmbrkedihqoutfylvzrnx
asgkjcmblkehihqoutfylvzpnx
asgwjjmbrkedvhqoutfhlvzpnx
asgwjcmbrkedihqoupzylvzknx
asgwjcmbukedchqoutfylizpnx
askwjcmdrkedihqoutwylvzpnx
asgwjcmbtkcdihloutfylvzpnx
asgwjcmbrkedwgqoutvylvzpnx
asmwjcmbrkedihqoutfylozpnc
asgwjcmbriedibqouofylvzpnx
asgnjcmcrkedihqoupfylvzpnx
asgzjcmbrksdihqoutiylvzpnx
asgwjcrbkkedihqouafylvzpnx
asgwjcmbkkvdihqqutfylvzpnx
astwjcqbrkedihqoutfylvzpvx
asgwjcmhrkehihqoutfylvzvnx
asgwjcmbraeduhqoutmylvzpnx
asgwjcmbrkedihquutnylvzptx
asgwjcmbrkedilqoftfylvzpnz
akgwjmmbrkedihqoutfylxzpnx
asgwjcmbrkhxikqoutfylvzpnx
asgcjcmetkedihqoutfylvzpnx
fsgwjcmsrkedihooutfylvzpnx
gsgwjcmbrkedihdoutfylvzdnx
asgwtccbrkedihqoutfylvwpnx
asuwjcmbrkedihqcutfylvzpox
asgwacmbrkodihqlutfylvzpnx
asgwjcmbrkediuqoutfylqhpnx
asgwjcmbrkwdrhqoutfylvzpno
angwjcsblkedihqoutfylvzpnx
aigwjcmbyoedihqoutfylvzpnx
adgwjcmbrkedihqtutfylyzpnx
asgwjzmbrkeeihqputfylvzpnx
asgwjcmbrkwdihqoutfylvzpwc
asgpjcmbrkgdihqbutfylvzpnx
osgwjmmbrkedijqoutfylvzpnx
asgjjcmbrkkdihqoutfylvzynx
asgwjcnerwedihqoutfylvzpnx
azgwhcmbrkedicqoutfylvzpnx
asnwjcmbrsedihqoutfylvzpnm
hsgwjcmgrkedihqoutfilvzpnx
asgwscmbrkjdihqoutfylvzpnm
asgbjbmbrkedhhqoutfylvzpnx
aswwjcmtrkedihqjutfylvzpnx
asgwicmbrbedihqoutfylvzpnm
asgwjcubrkedihqoutfylvbnnx
asvwjcmbrkehihqoutfylhzpnx
gsgwjcmbrkedihqoutsklvzpnx
asgwjcubikedihqoitfylvzpnx
asgwjpmbskedilqoutfylvzpnx
aigwjcmbrxedihqoutyylvzpnx
asgwjcpbrkedihxoutfynvzpnx
asgwjcmbrkegihqoutfklvzcnx
asgwjvubrkedjhqoutfylvzpnx
asgwjcabrkedihqoutfyivzplx
asgwjcxbrkedihqgutfylvepnx
asgwlcmbrkedihqoutqylvwpnx
asgwjhmbrkydihqhutfylvzpnx
asgwjcmbrkedihqoutfylwzone
asgwycmbrkadihqoutuylvzpnx
asgwjcybrkedihqoftfylvzpne
asgwjcmnrkedihrodtfylvzpnx
asgwicmwrkedihqoutfyovzpnx
aqgwjlmbrkedilqoutfylvzpnx
asgwjcmzskwdihqoutfylvzpnx
asgwjcmdrkebihqoutfylvjpnx
asgwjcmbrkpdihqoutfylxzphx
asgwjcmbrkedixqoutlylfzpnx
asgwjcmbrkadihqoutfylvlpdx
asgejcmqrkedyhqoutfylvzpnx
asgwjcmvroedihpoutfylvzpnx
asgwjcmxrkedihqoutfyivzpmx
