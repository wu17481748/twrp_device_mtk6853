#!/system/bin/sh
  i=1
  while [ $i -le 10 ]; do
    if [ -f /cache/runtime.prop ]; then
      config_conf="$(cat "/cache/runtime.prop" | egrep -v '^#')"
      product="$(echo "$config_conf" | egrep '^ro.build.product=' | sed -n 's/ro.build.product=//g;$p')"
      device="$(echo "$config_conf" | egrep '^ro.commonsoft.ota=' | sed -n 's/ro.commonsoft.ota=//g;$p')"
      soft="$(echo "$config_conf" | egrep '^ro.separate.soft=' | sed -n 's/ro.separate.soft=//g;$p')"
      name="$(echo "$config_conf" | egrep '^ro.oppo.market.name=' | sed -n 's/ro.oppo.market.name=//g;$p')"
      names="$(echo "$config_conf" | egrep '^ro.product.name=' | sed -n 's/ro.product.name=//g;$p')"
      model="$(echo "$config_conf" | egrep '^ro.product.model=' | sed -n 's/ro.product.model=//g;$p')"
      product1="ro.build.product=$product"
      device1="ro.commonsoft.ota=$device"
      soft1="ro.separate.soft=$soft"
      name1="ro.oppo.market.name=$name"
      names1="ro.product.name=$names"
      model1="ro.product.model=$model"
      echo "product is ${product}"
      echo "device is ${device}"
      echo "soft is ${soft}"
      echo "name is ${name}"
      echo "names is ${names}"
      echo "model is ${model}"
      
      if [ "$device" ]; then
        echo "change device"
        sed -i "s/^.*ro.commonsoft.ota.*$/$device1/" /prop.default
      fi
      
      if [ "$product" ]; then
        echo "change product"
        sed -i "s/^.*ro.build.product.*$/$product1/" /prop.default
      fi
      
      if [ "$soft" ]; then
        echo "change soft"
        sed -i "s/^.*ro.separate.soft.*$/$soft1/" /prop.default
      fi
      
      if [ "$name" ]; then
        echo "change name"
        sed -i "s/^.*ro.oppo.market.name.*$/$name1/" /prop.default
      fi
      
      if [ "$names" ]; then
        echo "change names"
        sed -i "s/^.*ro.product.name.*$/$name1/" /prop.default
      fi
      
      if [ "$model" ]; then
        echo "change model"
        sed -i "s/^.*ro.product.model.*$/$names1/" /prop.default
      fi
      
      resetprop --file /prop.default
      resetprop --file /default.prop
      break
    else
      sleep 1
      let i++
    fi
  done

stop modelchange
