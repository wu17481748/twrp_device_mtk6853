#!/system/bin/sh
sleep 4
i=0
  while [ $i -le 6 ]; do
    let i++
    sleep 1
    if [ -f /cache/runtime.prop ]; then
      config_conf="$(cat "/cache/runtime.prop" | egrep -v '^#')"
      brand="$(echo "$config_conf" | egrep '^ro.product.brand=' | sed -n 's/ro.product.brand=//g;$p')"
      product="$(echo "$config_conf" | egrep '^ro.build.product=' | sed -n 's/ro.build.product=//g;$p')"
      device="$(echo "$config_conf" | egrep '^ro.commonsoft.ota=' | sed -n 's/ro.commonsoft.ota=//g;$p')"
      soft="$(echo "$config_conf" | egrep '^ro.separate.soft=' | sed -n 's/ro.separate.soft=//g;$p')"
      name="$(echo "$config_conf" | egrep '^ro.vendor.oplus.market.name=' | sed -n 's/ro.vendor.oplus.market.name=//g;$p')"
      names="$(echo "$config_conf" | egrep '^ro.product.name=' | sed -n 's/ro.product.name=//g;$p')"
      model="$(echo "$config_conf" | egrep '^ro.product.model=' | sed -n 's/ro.product.model=//g;$p')"
      product1="ro.build.product=$product"
      device1="ro.commonsoft.ota=$device"
      soft1="ro.separate.soft=$soft"
      name1="ro.oppo.market.name=$name"
      name2="ro.product.system.model=$name"
      name3="ro.product.vendor.model=$name"
      name4="ro.product.odm.model=$name"
      name5="ro.product.product.model=$name"
      name6="ro.product.system_ext.model=$name"
      names1="ro.product.name=$names"
      model1="ro.product.model=$model"
      echo "product is ${product}"
      echo "device is ${device}"
      echo "soft is ${soft}"
      echo "name is ${name}"
      echo "names is ${names}"
      echo "model is ${model}"
      echo "brand is ${brand}"
      
      sed -i  "s/MTK6853/$device/g" /prop.default
      sed -i  "s/MTK/$brand/g" /prop.default
      
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
        sed -i "s/^.*ro.product.system.model.*$/$name2/" /prop.default
        sed -i "s/^.*ro.product.vendor.model.*$/$name3/" /prop.default
        sed -i "s/^.*ro.product.odm.model.*$/$name4/" /prop.default
        sed -i "s/^.*ro.product.product.model.*$/$name5/" /prop.default
        sed -i "s/^.*ro.product.system_ext.model.*$/$name6/" /prop.default
      fi
      
      if [ "$names" ]; then
        echo "change names"
        sed -i "s/^.*ro.product.name.*$/$name1/" /prop.default
      fi
      
      if [ "$model" ]; then
        echo "change model"
        sed -i "s/^.*ro.product.model.*$/$model1/" /prop.default
      fi
      
      resetprop --file /prop.default
      resetprop --file /default.prop
    fi
  done
