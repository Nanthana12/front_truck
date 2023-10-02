<template>
  <div class="pb-10">
    <v-dialog v-model="loading_processing" persistent width="55">
      <v-card width="55" height="55" class="pt-3 pl-3">
        <v-progress-circular :width="3" color="primary" indeterminate></v-progress-circular>
      </v-card>
    </v-dialog>
    <v-form ref="form" v-model="valid" lazy-validation>
      <v-card class="card-shadow" rounded="lg">
        <v-card-title style="display:flex;background-color:#568fb3;color:white">
          <v-btn fab elevation="0" dark width="30" height="30" small color="white" to="leave-cars-list">
            <v-icon color="#338ABF">mdi-arrow-left</v-icon>
          </v-btn>
          <v-spacer></v-spacer>
          ອອກໃບປ່ອຍລົດ
          <v-spacer></v-spacer>
        </v-card-title>

        <v-card-text class="pa-8">
          <!-- <div style="display:flex;align-items:center;border-radius:5px" class="mb-2">
            <span><span class="font-weight-bold">ລະຫັດໃບປ່ອຍລົດ:</span> {{ leave_id_car }}</span>
          </div> -->
          <div style="display:flex;justify-content:space-between;width:100%">
            <div style="background-color:#f5f5f5;width:100%;border-radius:5px" class="mr-6 pa-4">
              <div style="width:100%">
                <v-autocomplete outlined dense label="ເລືອກລູກຄ້າ" :items="customer_data_list" item-text="customerName"
                  item-value="id" @change="onGetCustomerDetails" :rules="nameRules"></v-autocomplete>
              </div>
              <div class="d-flex align-center ">
                <span>ລະຫັດລູກຄ້າ:</span>
                <span class="ml-4">{{ customer_id }}</span>
              </div>
              <div class="d-flex align-center">
                <span>ຊື່ລູກຄ້າ:</span>
                <span class="ml-4">{{ customer_name }}</span>
              </div>
              <div class="d-flex align-center">
                <span>ເບີໂທລູກຄ້າ:</span>
                <span class="ml-4">{{ customer_mobile }}</span>
              </div>
            </div>
            <div style="background-color:#f5f5f5;width:100%;border-radius:5px" class="pa-4">
              <div style="width:100%">
                <v-autocomplete outlined dense label="ເລືອກສິນຄ້າ" :items="products_data_list" item-text="proName"
                  item-value="id" @change="onGetProductDetails" :rules="nameRules"></v-autocomplete>
              </div>
              <div class="d-flex align-center">
                <span>ຊື່ສິນຄ້າ:</span>
                <span class="ml-4">{{ product_name }}</span>
              </div>
              <div class="d-flex align-center" style="width:100%">
                <v-text-field style="width:100%" label="ປ້ອນລາຄາ" outlined dense :rules="nameRules"
                  v-model="product_price"></v-text-field>

                <v-select label="ເລືອກສະກຸນເງິນ" style="width:100%" class="pl-2" outlined dense :items="currency_items"
                  v-model="currency" :rules="nameRules"></v-select>
              </div>
              <div class="d-flex align-center">
                <v-text-field label="ລາຄາລວມ" style="width:100%" readonly outlined dense :rules="nameRules"
                  v-model="total_price"></v-text-field>

                <div class="d-flex align-center pl-2" style="width:100%">
                  <v-text-field label="ປ້ອນນໍ້າໜັກ" style="width:100%" outlined dense v-model="product_weight"
                    :rules="nameRules"></v-text-field>
                  <div
                    style="height:40px;width:45px;margin-top:-26px;display:flex;align-items:center;justify-content:center;background-color:#4AAF41;margin-left:-2px">
                    <span class="white--text">ໂຕນ</span>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="d-flex align-center mt-6">
            <div style="background-color:#f5f5f5;width:100%;border-radius:5px" class="pa-4 mr-6">
              <div>
                <v-autocomplete outlined dense label="ເລືອກສະຖານທີ່ຕົ້ນທາງ" :items="loca_data_list" item-text="name"
                  item-value="id" @change="onGetLocaDetails" :rules="nameRules"></v-autocomplete>

              </div>
              <div class="pl-2 d-flex align-center">
                <span>ແຂວງ:</span>
                <span class="ml-4">{{ loca_send_province }}</span>
              </div>
              <div class="pl-2 d-flex align-center">
                <span>ສະຖານທີ:</span>
                <span class="ml-2">{{ loca_send_station }}</span>
              </div>
            </div>
            <v-spacer></v-spacer>
            <div style="background-color:#f5f5f5;width:100%;border-radius:5px" class="pa-4">
              <div>
                <v-autocomplete outlined dense label="ເລືອກສະຖານທີ່ປາຍທາງ" :items="loca_data_list" item-text="name"
                  item-value="id" @change="onGetLocaDetails1" :rules="nameRules"></v-autocomplete>
              </div>
              <div style="width:100%" class=" d-flex align-center">
                <span>ແຂວງ:</span>
                <span class="ml-2">{{ loca_recieve_province }}</span>
              </div>
              <div style="width:100%" class="d-flex align-center">
                <span>ສະຖານທີ:</span>
                <span class="ml-2">{{ loca_revieve_station }}</span>
              </div>
            </div>
          </div>

          <div class="d-flex align-center mt-6">
            <div style="background-color:#f5f5f5;width:100%;border-radius:5px" class="pa-4 mr-6">
              <div>
                <v-autocomplete outlined dense label="ເລືອກຄົນຂັບ1" :items="emplyee_list" item-text="name" item-value="id"
                  @change="onGetEmpDetails" :rules="nameRules"></v-autocomplete>
              </div>
              <div style="display:flex;align-items:center">
                <span>ເບີໂທລະສັບ:</span>
                <span class="ml-4">{{ emp_mobile }}</span>
              </div>
              <div style="display:flex;align-items:center">
                <span>ເລກໃບຂັບຂີ່:</span>
                <span class="ml-4">{{ emp_id_card }}</span>
              </div>
            </div>
            <v-spacer></v-spacer>
            <div style="background-color:#f5f5f5;width:100%;border-radius:5px" class="pa-4">
              <div>
                <v-autocomplete outlined dense label="ເລືອກຄົນຂັບ2" :items="emplyee_list" item-text="name" item-value="id"
                  @change="onGetEmpDetails1" :rules="nameRules"></v-autocomplete>
              </div>
              <div style="display:flex;align-items:center;width:100%;border-radius:5px">
                <span>ເບີໂທລະສັບ:</span>
                <span class="ml-4">{{ emp_mobile1 }}</span>
              </div>
              <div style="display:flex;align-items:center;width:100%;border-radius:5px">
                <span>ເລກໃບຂັບຂີ່:</span>
                <span class="ml-4">{{ emp_id_card1 }}</span>
              </div>
            </div>
          </div>

          <!-- money -->
          <div class="d-flex align-center mt-6 mb-6">
            <div style="width:100%;background-color:#f5f5f5;border-radius:5px" class="mr-6 pa-4">
              <div class="d-flex align-center">
                <div style="width:100%">
                  <v-text-field label="ບ້ຽງລ້ຽງ" outlined dense v-model="money" :rules="nameRules"></v-text-field>
                </div>
                <div style="width:100%" class="d-flex align-center pl-2">
                  <v-text-field label="ບ້ຽງລ້ຽງຈ່າຍກ່ອນ" outlined dense v-model="money_aready_pay"
                    :rules="nameRules"></v-text-field>
                </div>
              </div>
              <div class="d-flex align-center">
                <div style="width:100%" class="d-flex align-center">
                  <v-text-field readonly label="ຄ້າງຈ່າຍ" style="width:100%" outlined dense v-model="money_still_pay"
                    :rules="nameRules"></v-text-field>
                </div>
                <div class="d-flex align-center pl-2" style="width: 100%">
                  <v-select label="ເລືອກສະກຸນເງິນ" style="width:100" outlined dense :items="currency_items"
                    v-model="currency1" :rules="nameRules"></v-select>
                </div>
              </div>

            </div>
            <v-spacer></v-spacer>
            <!-- weight glass  ເບ້ຍລ້ຽງຄົນຂັບ 2 -->
            <div style="width:100%;background-color:#f5f5f5;border-radius:5px" class="pa-4">
              <div class="d-flex align-center">
                <div style="width:100%">
                  <v-text-field label="ບ້ຽງລ້ຽງ" outlined dense v-model="money1" :rules="nameRules"></v-text-field>

                </div>
                <div style="width:100%" class="d-flex align-center pl-2">
                  <v-text-field label="ບ້ຽງລ້ຽງຈ່າຍກ່ອນ" outlined dense v-model="money_aready_pay1"
                    :rules="nameRules"></v-text-field>
                </div>
              </div>
              <div class="d-flex align-center">
                <!-- <div class="d-flex align-center" style="width: 100%">
                <v-text-field dense outlined label="ເຄື່ອງມືຕິດລົດ" v-model="digital_with_car"
                  :rules="nameRules"></v-text-field>
              </div> -->
                <div class="d-flex align-center" style="width: 100%">
                  <v-text-field readonly label="ຄ້າງຈ່າຍ" style="width:100%" outlined dense v-model="money_still_pay1"
                    :rules="nameRules"></v-text-field>
                </div>
              </div>
            </div>
          </div>

          <div class="d-flex align-center mt-6">
            <div style="background-color:#f5f5f5;width:100%;border-radius:5px" class="pa-4 mr-6">
              <div style="width:100%">
                <v-autocomplete outlined dense label="ເລືອກຫົວລົດ" :items="cars_list" item-text="h_VICIVLE_NUMBER"
                  item-value="key_id" @change="onGetCarDetails" :rules="nameRules"></v-autocomplete>
              </div>
              <div style="width:100%" class="d-flex align-center pl-2">
                <span>ປ້າຍຫົວລົດ:</span>
                <span class="ml-4"> {{ h_VICIVLE_NUMBER }}</span>
              </div>
            </div>
            <v-spacer></v-spacer>
            <div style="background-color:#f5f5f5;width:100%;border-radius:5px" class="pa-4">
              <div style="width:100%">
                <v-autocomplete outlined dense label="ເລືອກຫາງລົດ" :items="truct_footer_data_list" item-text="f_CARD_NO"
                  item-value="key_id" @change="onGetTructFooterDetail" :rules="nameRules"></v-autocomplete>
              </div>
              <div style="width:100%" class="d-flex align-center pl-2">
                <span>ປ້າຍຫາງລົດ:</span>
                <span class="ml-4"> {{ f_CARD_NO }}</span>
              </div>
            </div>
          </div>
          <!-- start date and end date -->
          <div class="d-flex align-center mt-6 mb-6">
            <div style="width:100%;background-color:#f5f5f5;border-radius:5px" class="mr-6 pa-4">
              <div class="d-flex align-center">
                <div style="width:100%">
                  <v-menu ref="start_go_menu" v-model="start_go_menu" :close-on-content-click="false"
                    :return-value.sync="start_go_date" transition="scale-transition" offset-y min-width="auto">
                    <template v-slot:activator="{ on, attrs }">
                      <v-text-field dense outlined v-model="start_go_date" required label="ວັນທີອອກເດີນທາງ"
                        append-icon="mdi-calendar" readonly v-bind="attrs" v-on="on" :rules="nameRules"></v-text-field>
                    </template>
                    <v-date-picker v-model="start_go_date" no-title scrollable
                      @input="$refs.start_go_menu.save(start_go_date)">
                      <v-spacer></v-spacer>
                    </v-date-picker>
                  </v-menu>
                </div>
                <div style="width:100%" class="d-flex align-center pl-2">
                  <v-menu ref="end_menu" v-model="end_menu" :close-on-content-click="false" :return-value.sync="end_date"
                    transition="scale-transition" offset-y min-width="auto">
                    <template v-slot:activator="{ on, attrs }">
                      <v-text-field dense outlined v-model="end_date" required label="ວັນທີກັບ" append-icon="mdi-calendar"
                        readonly v-bind="attrs" v-on="on" :rules="nameRules"></v-text-field>
                    </template>
                    <v-date-picker v-model="end_date" no-title scrollable @input="$refs.end_menu.save(end_date)">
                      <v-spacer></v-spacer>
                    </v-date-picker>
                  </v-menu>
                </div>
              </div>
              <div class="d-flex align-center">
                <div style="width:100%" class="d-flex align-center">
                  <v-text-field dense outlined label="ໄລຍະທາງຂົນສົ່ງ" v-model="road_send_km"
                    :rules="nameRules"></v-text-field>
                </div>
                <div class="d-flex align-center pl-2" style="width: 100%">
                  <!-- <v-text-field dense outlined label="ເລກໄມປ່ຽນລີນກົ້ນ" v-model="let_mai_pian_lin_kund"></v-text-field> -->
                  <v-text-field dense outlined label="ໃສ່ນໍ້າມັນ" v-model="truck_glass" :rules="nameRules"></v-text-field>
                </div>
              </div>

            </div>
            <v-spacer></v-spacer>
            <!-- weight glass  ເລກໄມປ່ຽນນໍ້າມັນເຄື່ອງຮອບຕໍ່ໄປ ເລກໄມປ່ຽນລີນເກຍ-->
            <div style="width:100%;background-color:#f5f5f5;border-radius:5px" class="pa-4">
              <div class="d-flex align-center">
                <div style="width:100%">
                  <v-text-field dense outlined label="ນໍ້າໜັກລົດ" v-model="truck_weight"
                    :rules="nameRules"></v-text-field>

                </div>
                <div style="width:100%" class="d-flex align-center pl-2">
                  <v-text-field dense outlined label="ກ້ອງໜ້າລົດ" v-model="start_camera"
                    :rules="nameRules"></v-text-field>
                </div>
              </div>
              <div class="d-flex align-center">
                <!-- <div class="d-flex align-center" style="width: 100%">
                <v-text-field dense outlined label="ເຄື່ອງມືຕິດລົດ" v-model="digital_with_car"
                  :rules="nameRules"></v-text-field>
              </div> -->
                <div class="d-flex align-center" style="width: 100%">
                  <v-text-field dense outlined label="ລາຄານໍ້າມັນຕໍ່ລິດ" v-model="priceNamMun"
                    :rules="nameRules"></v-text-field>
                </div>
              </div>
            </div>
          </div>
        </v-card-text>

        <div
          style="position:fixed;top: 97%;left: 50%;transform: translate(-50%, -50%); width:100%;background-color:#f5f5f5;display:flex;justify-content:center;height:50px;align-items:center">
          <v-btn width="200" color="green" class="card-shadow" @click="onCreateReports">
            <v-icon color="white">mdi-printer</v-icon>
            <span class="white--text pl-2">ພີມບິນ</span>
          </v-btn>
        </div>
      </v-card>
    </v-form>

    <!--  -->
    <!-- component for print -->
    <div style="display:none;">
      <div id="modalInvoice">
        <div class="text-center pb-10 font-weight-bold" style="display:flex;justify-content:center;font-size:20px">
          <b>ໃບປ່ອຍລົດ</b>
        </div>
        <div style="height:20px; padding-top:20px"></div>

        <v-row>
          <v-col cols="3">
            <img class="mx-auto" src="../assets/images/cargo-truck.png" height="110px" width="110px" cover />
          </v-col>
          <v-col cols="9">
            <Height />
            <Height />
            <div style="display:flex;justify-content:end;flex-direction:column;align-items:end">
              <span style="font-size:14px">ເລກທີ: {{ leave_id_car }}</span>
              <span style="font-size:14px">ວັນທີອອກລົດ: {{ start_go_date }}</span>
              <span style="font-size:14px">ວັນທີກັບ: {{ end_date }}</span>
            </div>
          </v-col>

        </v-row>

        <!-- customer -->
        <div style="display:flex;flex-direction:row;justify-content:space-between;padding-top:20px">
          <table style="padding:2px;border: 0.5px solid #999;border-collapse: collapse;width:100%" class="mt-4">
            <tr style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px">
              <td colspan="4"
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px;">
                <div style="width:100%;display:flex;justify-content:space-between;">
                  <span style="font-size:14px"> <b>ຊື່ລູກຄ້າ:</b> {{ customer_name }}</span>
                </div>
                <div style="display:flex;justify-content:space-between">
                  <span style="font-size:14px"><b> ເບີໂທ: </b>{{ customer_mobile }}</span>
                </div>
              </td>
            </tr>
            <tr>
              <td colspan="2"
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px;">
                <div style="display:flex;flex-direction:row;justify-content:space-between;">

                  <div style="width:100%"><span style="font-size:14px">ແຂວງທີ່ສົ່ງ: {{ loca_send_province }}</span></div>

                </div>
                <div style="display:flex;flex-direction:row;justify-content:space-between;">
                  <div style="width:100%"><span style="font-size:14px">ສະຖານທີສົ່ງ: {{ loca_send_station }}</span></div>
                </div>
              </td>
              <td colspan="2"
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px;">
                <div style="display:flex;flex-direction:row;justify-content:space-between;">
                  <div style="width:100%;display:flex;align-items:end"><span style="font-size:14px">ແຂວງຮັບ: {{
                    loca_recieve_province }}</span>
                  </div>
                </div>
                <div style="display:flex;flex-direction:row;justify-content:space-between;">

                  <div style="width:100%"><span style="font-size:14px">ສະຖານທີຮັບ: {{ loca_revieve_station }}</span></div>
                </div>
              </td>
            </tr>
            <tr
              style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px; font-size: 14px;">
              <td
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                class="font-weight-bold">
                <div style="width:100%;display:flex;justify-content:center;align-items:center">
                  <span>ໄລຍະທາງຂົນສົ່ງ</span>
                </div>
              </td>
              <td
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                class="font-weight-bold">
                <div style="width:100%;display:flex;justify-content:center;align-items:center">
                  <span>ເຂັມກິໂລແມັດ</span>
                </div>
              </td>
              <td colspan="2"
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                class="font-weight-bold">
                <div style="width:100%;display:flex;justify-content:center;align-items:center">
                  <span>ເລກໄມປ່ຽນນໍ້າມັນເຄື່ອງຮອບຕໍ່ໄປ</span>
                </div>
              </td>
              <!-- <td
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                class="font-weight-bold">
                <div style="width:100%;display:flex;justify-content:center;align-items:center">
                  <span>ລວມ</span>
                </div>
              </td> -->
            </tr>
            <tr style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px">
              <td
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px;">
                <div style="width:100%;display:flex;justify-content:center;">
                  <span style="font-size:14px"> {{ road_send_km }} Km</span>
                </div>
              </td>
              <td
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px;">
                <div style="width:100%;display:flex;justify-content:center;">
                  <span style="font-size:14px"> {{ kim_KM }} </span>
                </div>
              </td>
              <td colspan="2"
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px;">
                <div style="width:100%;display:flex;justify-content:center;">
                  <span style="font-size:14px"> {{ let_mai_pian_num_mun_kheng_next }}</span>
                </div>
              </td>
              <!-- <td
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px;">
                <div style="width:100%;display:flex;justify-content:end;">
                  <span style="font-size:14px"> {{ total_price }} {{ currency }}</span>
                </div>
              </td> -->
            </tr>
          </table>
        </div>


        <div style="display:flex;flex-direction:row;justify-content:space-between;padding-top:20px">
          <table style="padding:2px;border: 0.5px solid #999;border-collapse: collapse;width:100%" class="mt-4">
            <tr style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px">
              <td colspan="4"
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px;">
                <div style="width:100%;display:flex;justify-content:center;">
                  <span style="font-size:16px"> <b>ຂໍ້ມູນພະນັກງານຂັບລົດ</b></span>
                </div>
              </td>
            </tr>
            <tr>
              <td colspan="2"
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px;">
                <v-row>
                  <v-col cols="3">
                    <img class="mx-auto" src="../assets/images/profile.png" height="70px" width="70px" cover />
                  </v-col>
                  <v-col cols="9">
                    <div style="display:flex;flex-direction:row;justify-content:space-between;">

                      <div style="width:100%"><span style="font-size:14px">ຄົນຂັບ1: {{ emp_name }} </span></div>

                    </div>
                    <div style="display:flex;flex-direction:row;justify-content:space-between;">
                      <div style="width:100%"><span style="font-size:14px">ເບີໂທ: {{ emp_mobile }}</span></div>
                    </div>
                    <div style="display:flex;flex-direction:row;justify-content:space-between;">
                      <div style="width:100%"><span style="font-size:14px"> ເລກໃບຂັບຂີ່: {{ emp_id_card }}</span></div>
                    </div>
                  </v-col>
                </v-row>

              </td>
              <td colspan="2"
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px;">
                <v-row>
                  <v-col cols="3">
                    <img class="mx-auto" src="../assets/images/profile.png" height="70px" width="70px" cover />
                  </v-col>
                  <v-col cols="9">
                    <div style="display:flex;flex-direction:row;justify-content:space-between;">
                      <div style="width:100%"><span style="font-size:14px">ຄົນຂັບ2: {{ emp_name1 }} </span></div>
                    </div>
                    <div style="display:flex;flex-direction:row;justify-content:space-between;">
                      <div style="width:100%"><span style="font-size:14px">ເບີໂທ: {{ emp_mobile1 }}</span></div>
                    </div>
                    <div style="display:flex;flex-direction:row;justify-content:space-between;">
                      <div style="width:100%"><span style="font-size:14px"> ເລກໃບຂັບຂີ່: {{ emp_id_card1 }}</span></div>
                    </div>
                  </v-col>
                </v-row>

              </td>
            </tr>
            <tr
              style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px; font-size: 14px;">
              <td
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                class="font-weight-bold">
                <div style="width:100%;display:flex;justify-content:start">
                  <span>ເບ້ຍລ້ຽງທັງໝົດ:</span>
                </div>
              </td>
              <td
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                class="font-weight-bold">
                <div style="width:100%;display:flex;justify-content:end">
                  <span>{{ money }} {{ currency1 }}</span>
                </div>
              </td>
              <td
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                class="font-weight-bold">
                <div style="width:100%;display:flex;justify-content:start">
                  <span>ເບ້ຍລ້ຽງທັງໝົດ:</span>
                </div>
              </td>
              <td
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                class="font-weight-bold">
                <div style="width:100%;display:flex;justify-content:end">
                  <span>{{ money1 }} {{ currency1 }}</span>
                </div>
              </td>
            </tr>
            <tr
              style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px; font-size: 14px;">
              <td
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                class="font-weight-bold green--text">
                <div style="width:100%;display:flex;justify-content:start">
                  <span>ເບ້ຍລ້ຽງຈ່າຍກ່ອນ:</span>
                </div>
              </td>
              <td
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                class="font-weight-bold green--text">
                <div style="width:100%;display:flex;justify-content:end">
                  <span>{{ money_aready_pay }} {{ currency1 }}</span>
                </div>
              </td>
              <td
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                class="font-weight-bold green--text">
                <div style="width:100%;display:flex;justify-content:start">
                  <span>ເບ້ຍລ້ຽງຈ່າຍກ່ອນ:</span>
                </div>
              </td>
              <td
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                class="font-weight-bold green--text">
                <div style="width:100%;display:flex;justify-content:end">
                  <span>{{ money_aready_pay1 }} {{ currency1 }}</span>
                </div>
              </td>
            </tr>
            <tr
              style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px; font-size: 14px;">
              <td
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                class="font-weight-bold ">
                <div style="width:100%;display:flex;justify-content:start">
                  <span>ໃສ່ນໍ້າມັນ:</span>
                </div>
              </td>
              <td
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                class="font-weight-bold">
                <div style="width:100%;display:flex;justify-content:end">
                  <span>{{ truck_glass }} ລິດ</span>
                </div>
              </td>
              <td
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                class="font-weight-bold">
                <div style="width:100%;display:flex;justify-content:start">
                  <span>ລາຄານໍ້າມັນຕໍ່ລິດ</span>
                </div>
              </td>
              <td
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                class="font-weight-bold">
                <div style="width:100%;display:flex;justify-content:end">
                  <span>{{ priceNamMun }} LAK</span>
                </div>
              </td>
            </tr>
            <tr
              style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px; font-size: 14px;">
              <td colspan="2"
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                class="font-weight-bold">
                <div style="width:100%;display:flex;justify-content:end">
                  <span>ລາຄານໍ້າມັນທັງໝົດ:</span>
                </div>
              </td>
              <td colspan="2"
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                class="font-weight-bold">
                <div style="width:100%;display:flex;justify-content:end">
                  <span>{{ priceNamMun_Total }} LAK</span>
                </div>
              </td>
            </tr>
            <tr
              style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px; font-size: 14px;">
              <td colspan="2"
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                class="font-weight-bold">
                <div style="width:100%;display:flex;justify-content:end">
                  <span>ຈ່າຍເງິນບ້ຽງລ້ຽງຕົວຈິງ:</span>
                </div>
              </td>
              <td colspan="2"
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                class="font-weight-bold">
                <div style="width:100%;display:flex;justify-content:end">
                  <span>{{ moneyareadyAll }} LAK</span>
                </div>
              </td>
            </tr>
            <tr
              style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px; font-size: 14px;">
              <td colspan="2"
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                class="font-weight-bold">
                <div style="width:100%;display:flex;justify-content:end">
                  <span>ລວມລາຍຈ່າຍທັງໝົດ:</span>
                </div>
              </td>
              <td colspan="2"
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                class="font-weight-bold">
                <div style="width:100%;display:flex;justify-content:end">
                  <span> LAK</span>
                </div>
              </td>
            </tr>
          </table>
        </div>

        <!-- employee -->
        <!-- <div style="display:flex;flex-direction:row;justify-content:space-between;">
          <div style="width:100%;display:flex;align-items:end"><span style="font-size:12pt">ຄົນຂັບ1: {{ emp_name
          }} {{ }}</span></div>
          <div style="width:100%"><span style="font-size:12pt">ເບີໂທ: {{ emp_mobile }}</span></div>
          <div style="width:100%"><span style="font-size:12pt">ເລກໃບຂັບຂີ່: {{ emp_id_card }}</span></div>
        </div>
        <div style="display:flex;flex-direction:row;justify-content:space-between;">
          <div style="width:100%;display:flex;align-items:end"><span style="font-size:12pt">ຄົນຂັບ2: {{ emp_name1
          }}</span></div>
          <div style="width:100%"><span style="font-size:12pt">ເບີໂທ: {{ emp_mobile1 }}</span></div>
          <div style="width:100%"><span style="font-size:12pt">ເລກໃບຂັບຂີ່: {{ emp_id_card1 }}</span></div>
        </div>
        <div style="display:flex;flex-direction:row;justify-content:space-between;">
          <div style="width:100%;display:flex;align-items:end"><span style="font-size:12pt">ບ້ຽງລ້ຽງ: {{ money }} {{
            currency1 }}</span>
          </div>
          <div style="width:100%"><span style="font-size:12pt">ຈ່າຍກ່ອນ: {{ money_aready_pay }} {{ currency1 }}</span>
          </div>
          <div style="width:100%"><span style="font-size:12pt">ຄ້າງຈ່າຍ: {{ money_still_pay1 }} {{ currency1 }}</span>
          </div>
        </div> -->
        <!-- truck -->
        <!-- <div style="display:flex;flex-direction:row;justify-content:space-between;">
          <div style="width:100%;display:flex;align-items:end"><span style="font-size:12pt">ວັນທີອອກ: {{ start_go_date
          }}</span>
          </div>
          <div style="width:100%"><span style="font-size:12pt">ວັນທີກັບ: {{ end_date }}</span></div>
          <div style="width:100%"> -->
        <!-- <span style="font-size:12pt">ເລກໄມປ່ຽນລີນກົ້ນ: {{ let_mai_pian_lin_kund }}</span> -->
        <!-- </div>
        </div> -->
        <!-- <div style="display:flex;flex-direction:row;justify-content:space-between;">
          <div style="width:100%;display:flex;align-items:end"><span style="font-size:12pt">ໄລຍະທາງຂົນສົ່ງ: {{
            road_send_km
          }}</span></div>
          <div style="width:100%"><span style="font-size:12pt">ໃສ່ນໍ້າມັນ: {{ truck_glass }} ລິດ</span></div>
          <div style="width:100%"><span style="font-size:12pt">ນໍ້າໜັກລົດ: {{ truck_weight }}</span></div>
        </div>
        <div style="display:flex;flex-direction:row;justify-content:space-between;">
          <div style="width:80%;display:flex;align-items:end"><span style="font-size:12pt">ເລກໄມປ່ຽນນໍ້າມັນເຄື່ອງຮອບຕໍ່ໄປ:
              {{ let_mai_pian_num_mun_kheng_next }}</span></div>
        </div>
        <div style="display:flex;flex-direction:row;justify-content:space-between;">
          <div style="width:100%;display:flex;align-items:end"> -->
        <!-- <span style="font-size:12pt">ໝໍ້ໄຟ: {{ mong_fai }}</span> -->
        <!-- <span style="font-size:12pt">ເຂັມກິໂລແມັດ: {{ kim_KM }}</span>
          </div> -->
        <!-- <div style="width:100%">
            <span style="font-size:12pt">ເຄື່ອງມືຕິດລົດ: {{
              digital_with_car }}</span>
          </div> -->
        <!-- <div style="width:100%"><span style="font-size:12pt">ກ້ອງໜ້າລົດ: {{ start_camera }}</span></div>
        </div> -->



        <!-- head and footer general data -->
        <div style="display:flex;flex-direction:row;justify-content:space-between;padding-top:20px">
          <div style="width:100%;padding-right:10px" class="pr-2">
            <table style="padding:2px;border: 0.5px solid #999;border-collapse: collapse;width:100%">
              <tr style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px">
                <td colspan="3"
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px; ">
                  <div style="width:100%;display:flex;justify-content:center;align-items:center; font-size: 18px;"
                    class="font-weight-bold ">
                    <span><b>ຂໍ້ມູນຫົວລົດ</b> </span>
                  </div>
                  <div style="width:100%;display:flex;justify-content:space-between;" class="mt-2">
                    <span style="font-size:14px">ທະບຽນລົດ: {{ h_VICIVLE_NUMBER }}</span>
                  </div>
                  <div style="display:flex;justify-content:space-between">
                    <span style="font-size:14px">ຍີ່ຫໍ້: {{ h_VICIVLE_BRANCH }}</span>
                  </div>
                  <div style="display:flex;justify-content:space-between">
                    <span style="font-size:14px">ລົດປີ: {{ h_VICIVLE_YEARLEVEL }}</span>
                  </div>
                  <div style="display:flex;justify-content:space-between">
                    <span style="font-size:14px">ເລກປະກັນໄພ: {{ h_VICIVLE_GALATY }}</span>
                  </div>
                  <div style="display:flex;justify-content:space-between">
                    <span style="font-size:14px">ປະກັນໄພໝົດ: {{ h_VICIVLE_DATE_GALATY }}</span>
                  </div>
                  <div style="display:flex;justify-content:space-between;flex-direction:column">
                    <span style="font-size:14px">ເລກຈັກ: {{ h_VICIVLE_LEKJUK }}</span>
                    <span style="font-size:14px">ເລກຖັງ: {{ h_VICIVLE_LEKTHUNG }}</span>
                  </div>
                </td>
              </tr>
              <tr
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px; font-size: 14px;">
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                  class="font-weight-bold">
                  <div style="width:100%;display:flex;justify-content:center;align-items:center">
                    <span>ລະຫັດຢາງລົດ</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                  class="font-weight-bold">
                  <div style="width:100%;display:flex;justify-content:center;align-items:center">
                    <span>ວັນທີປ່ຽນ</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                  class="font-weight-bold">
                  <div style="width:100%;display:flex;justify-content:center;align-items:center">
                    <span>ກຳນົດແລ່ນໄດ້</span>
                  </div>
                </td>
              </tr>
              <tr
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px; font-size: 12px;">
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ ll_TIRE_NO_1 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ ll_TIRE_DATE_1 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ ll_TIRE_KM_1 }}</span>
                  </div>
                </td>
              </tr>
              <tr
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px; font-size: 12px;">
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ ll_TIRE_NO_2 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ ll_TIRE_DATE_2 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ ll_TIRE_KM_2 }}</span>
                  </div>
                </td>
              </tr>
              <tr
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px; font-size: 12px;">
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ ll_TIRE_NO_3 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ ll_TIRE_DATE_3 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ ll_TIRE_KM_3 }}</span>
                  </div>
                </td>
              </tr>
              <tr
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px; font-size: 12px;">
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ ll_TIRE_NO_4 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ ll_TIRE_DATE_4 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ ll_TIRE_KM_4 }}</span>
                  </div>
                </td>
              </tr>
              <tr
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px; font-size: 12px;">
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ ll_TIRE_NO_5 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ ll_TIRE_DATE_5 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ ll_TIRE_KM_5 }}</span>
                  </div>
                </td>
              </tr>
              <tr
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px; font-size: 12px;">
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ ll_TIRE_NO_6 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ ll_TIRE_DATE_6 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ ll_TIRE_KM_6 }}</span>
                  </div>
                </td>
              </tr>
              <tr
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px; font-size: 12px;">
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ r_TIRE_NO_1 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ r_TIRE_DATE_1 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ r_TIRE_KM_1 }}</span>
                  </div>
                </td>
              </tr>
              <tr
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px; font-size: 12px;">
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ r_TIRE_NO_2 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ r_TIRE_DATE_2 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ r_TIRE_KM_2 }}</span>
                  </div>
                </td>
              </tr>
              <tr
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px; font-size: 12px;">
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ r_TIRE_NO_3 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ r_TIRE_DATE_3 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ r_TIRE_KM_3 }}</span>
                  </div>
                </td>
              </tr>
              <tr
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px; font-size: 12px;">
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ r_TIRE_NO_4 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ r_TIRE_DATE_4 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ r_TIRE_KM_4 }}</span>
                  </div>
                </td>
              </tr>
              <tr
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px; font-size: 12px;">
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ r_TIRE_NO_5 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ r_TIRE_DATE_5 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ r_TIRE_KM_5 }}</span>
                  </div>
                </td>
              </tr>
              <tr
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px; font-size: 12px;">
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ r_TIRE_NO_6 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ r_TIRE_DATE_6 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ r_TIRE_KM_6 }}</span>
                  </div>
                </td>
              </tr>
            </table>
          </div>
          <div style="width:100%;padding-left:10px">
            <table style="padding:2px;border: 0.5px solid #999;border-collapse: collapse;width:100%">
              <tr style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px">
                <td colspan="3"
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px; ">
                  <div style="width:100%;display:flex;justify-content:center;align-items:center; font-size: 18px;"
                    class="font-weight-bold ">
                    <span><b>ຂໍ້ມູນຫາງລົດ</b> </span>
                  </div>
                  <div style="width:100%;display:flex;justify-content:space-between;" class="mt-2">
                    <span style="font-size:14px">ທະບຽນລົດ: {{ f_CARD_NO }}</span>
                  </div>
                  <div style="display:flex;justify-content:space-between">
                    <span style="font-size:14px">ຍີ່ຫໍ້: {{ f_BRANCH }}</span>
                  </div>
                  <div style="display:flex;justify-content:space-between">
                    <span style="font-size:14px">ລົດປີ: {{ f_YEAR }}</span>
                  </div>
                  <div style="display:flex;justify-content:space-between">
                    <span style="font-size:14px">ເລກປະກັນໄພ: {{ h_VICIVLE_GALATY }}</span>
                  </div>
                  <div style="display:flex;justify-content:space-between">
                    <span style="font-size:14px">ປະກັນໄພໝົດ: {{ f_GALATY_DEP }}</span>
                  </div>
                  <div style="display:flex;justify-content:space-between;flex-direction:column">
                    <span style="font-size:14px">ເລກຄັນຊີ: {{ f_LEKKUNZEE }}</span>
                  </div>
                </td>
              </tr>
              <tr
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px; font-size: 14px;">
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                  class="font-weight-bold">
                  <div style="width:100%;display:flex;justify-content:center;align-items:center">
                    <span>ລະຫັດຢາງລົດ</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                  class="font-weight-bold">
                  <div style="width:100%;display:flex;justify-content:center;align-items:center">
                    <span>ວັນທີປ່ຽນ</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                  class="font-weight-bold">
                  <div style="width:100%;display:flex;justify-content:center;align-items:center">
                    <span>ກຳນົດແລ່ນໄດ້</span>
                  </div>
                </td>
              </tr>
              <tr
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px; font-size: 12px;">
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ bl_TRIES_1 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ bl_TRIES_DATE_1 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ bl_TRIES_KM_1 }}</span>
                  </div>
                </td>
              </tr>
              <tr
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px; font-size: 12px;">
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ bl_TRIES_2 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ bl_TRIES_DATE_2 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ bl_TRIES_KM_1 }}</span>
                  </div>
                </td>
              </tr>
              <tr
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px; font-size: 12px;">
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ bl_TRIES_3 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ bl_TRIES_DATE_3 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ bl_TRIES_KM_3 }}</span>
                  </div>
                </td>
              </tr>
              <tr
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px; font-size: 12px;">
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ bl_TRIES_4 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ bl_TRIES_DATE_4 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ bl_TRIES_KM_4 }}</span>
                  </div>
                </td>
              </tr>
              <tr
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px; font-size: 12px;">
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ bl_TRIES_5 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ bl_TRIES_DATE_5 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ bl_TRIES_KM_5 }}</span>
                  </div>
                </td>
              </tr>
              <tr
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px; font-size: 12px;">
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ bl_TRIES_6 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ bl_TRIES_DATE_6 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ bl_TRIES_KM_6 }}</span>
                  </div>
                </td>
              </tr>
              <tr
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px; font-size: 12px;">
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ bl_TRIES_7 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ bl_TRIES_DATE_7 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ bl_TRIES_KM_7 }}</span>
                  </div>
                </td>
              </tr>
              <tr
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px; font-size: 12px;">
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ bl_TRIES_8 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ bl_TRIES_DATE_8 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ bl_TRIES_KM_8 }}</span>
                  </div>
                </td>
              </tr>
              <tr
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px; font-size: 12px;">
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ br_TRIES_1 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ br_TRIES_DATE_1 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ br_TRIES_KM_1 }}</span>
                  </div>
                </td>
              </tr>
              <tr
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px; font-size: 12px;">
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ br_TRIES_2 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ br_TRIES_DATE_2 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ br_TRIES_KM_2 }}</span>
                  </div>
                </td>
              </tr>
              <tr
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px; font-size: 12px;">
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ br_TRIES_3 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ br_TRIES_DATE_3 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ br_TRIES_KM_3 }}</span>
                  </div>
                </td>
              </tr>
              <tr
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px; font-size: 12px;">
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ br_TRIES_4 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ br_TRIES_DATE_4 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ br_TRIES_KM_4 }}</span>
                  </div>
                </td>
              </tr>
              <tr
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px; font-size: 12px;">
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ br_TRIES_5 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ br_TRIES_DATE_5 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ br_TRIES_KM_5 }}</span>
                  </div>
                </td>
              </tr>
              <tr
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px; font-size: 12px;">
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ br_TRIES_6 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ br_TRIES_DATE_6 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ br_TRIES_KM_6 }}</span>
                  </div>
                </td>
              </tr>
              <tr
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px; font-size: 12px;">
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ br_TRIES_7 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ br_TRIES_DATE_7 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ br_TRIES_KM_7 }}</span>
                  </div>
                </td>
              </tr>
              <tr
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px; font-size: 12px;">
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ br_TRIES_8 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ br_TRIES_DATE_8 }}</span>
                  </div>
                </td>
                <td
                  style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px">
                  <div style="width:100%;display:flex;justify-content:space-between">
                    <span>{{ br_TRIES_KM_8 }}</span>
                  </div>
                </td>
              </tr>
            </table>
          </div>
        </div>
        <div style="display:flex;flex-direction:row;justify-content:space-between;padding-top:100px">
          <span style="font-size:12pt">ຜູ້ຮັບຜິດຊອບປ່ອຍລົດ</span>
          <span style="font-size:12pt">ຜູ້ຂົນສົ່ງສິນຄ້າ</span>
          <span style="font-size:12pt">ຫົວໜ້າຄຸມງານ</span>
          <span style="font-size:12pt">ຜູ້ຮັບສິນຄ້າປາຍທາງ</span>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import swal from 'sweetalert2'
export default {
  data() {
    return {
      currency: '',
      currency1: '',
      currency_items: ['LAK', 'USD', 'THB', 'CNY'],
      priceNamMun: '',
      leave_id_car: [],
      product_price: '',
      total_price: '',
      valid: true,
      nameRules: [(v) => !!v || 'ຕ້ອງປ້ອນ'],
      loading_processing: false,
      open_dialog_print: false,

      //start and end date
      start_go_menu: false,
      end_menu: false,
      start_go_date: null,
      end_date: null,
      cars_category_list: [],
      leave_card_no: '',

      // l_plate_No: '',
      // fullName: '',
      //==========truck
      cars_list: [],
      // truck_key: '',
      t_year: '',
      t_type: '',
      t_model: '',
      t_tek_nik_ex: '',
      truck_plateNo_start: '',
      truck_start_color: '',
      truck_plateNo_end: '',
      truck_end_color: '',
      truck_type: '',
      truck_type1: '',
      road_send_km: '',
      let_mai_pian_lin_kund: '',
      truck_glass: '',
      truck_weight: '',
      let_mai_pian_num_mun_kheng_next: '',
      let_mai_pian_lin_kia: '',
      mong_fai: '',
      GPS: '',
      start_camera: '',
      digital_with_car: '',
      truck_kilomen: '',
      staff_Status01: '',
      staff_Status02: '',

      // truck_plate_detail: '',
      // truck_type: '',
      //employee
      emplyee_list: [],
      emp_name: '',
      emp_mobile: '',
      emp_id_card: '',
      emp_name1: '',
      emp_mobile1: '',
      emp_id_card1: '',
      money: '',
      money_aready_pay: '',
      money_still_pay: '',
      money1: '',
      money_aready_pay1: '',
      money_still_pay1: '',
      money_aready_All: '',
      Total_money: '',

      //========location
      loca_data_list: [],
      loca_send_province: '',
      loca_send_station: '',
      loca_recieve_province: '',
      loca_revieve_station: '',
      //=====customer
      customer_data_list: [],
      customer_name: '',
      customer_mobile: '',
      customer_id: '',
      //========products
      products_data_list: [],
      product_name: '',
      product_quality: '',
      product_weight: '',
      product_detail: '',
      province_send: '',
      station_send: '',
      province_receiv: '',
      station_receiv: '',
      detail_send: '',
      detail_recive: '',

      // card kia position


      // head data for bill
      h_VICIVLE_NUMBER: '',
      h_VICIVLE_BRANCH: '',
      h_VICIVLE_YEARLEVEL: '',
      h_VICIVLE_GALATY: '',
      h_VICIVLE_DATE_GALATY: '',
      h_VICIVLE_LEKJUK: '',
      h_VICIVLE_LEKTHUNG: '',
      kim_KM: '',
      f_LEKKUNZEE: '',
      ll_TIRE_NO_1: '',
      ll_TIRE_NO_2: '',
      ll_TIRE_NO_3: '',
      ll_TIRE_NO_4: '',
      ll_TIRE_NO_5: '',
      ll_TIRE_NO_6: '',

      r_TIRE_NO_1: '',
      r_TIRE_NO_2: '',
      r_TIRE_NO_3: '',
      r_TIRE_NO_4: '',
      r_TIRE_NO_5: '',
      r_TIRE_NO_6: '',

      ll_TIRE_DATE_1: '',
      ll_TIRE_DATE_2: '',
      ll_TIRE_DATE_3: '',
      ll_TIRE_DATE_4: '',
      ll_TIRE_DATE_5: '',
      ll_TIRE_DATE_6: '',

      r_TIRE_DATE_1: '',
      r_TIRE_DATE_2: '',
      r_TIRE_DATE_3: '',
      r_TIRE_DATE_4: '',
      r_TIRE_DATE_5: '',
      r_TIRE_DATE_6: '',

      ll_TIRE_KM_1: '',
      ll_TIRE_KM_2: '',
      ll_TIRE_KM_3: '',
      ll_TIRE_KM_4: '',
      ll_TIRE_KM_5: '',
      ll_TIRE_KM_6: '',

      r_TIRE_KM_1: '',
      r_TIRE_KM_2: '',
      r_TIRE_KM_3: '',
      r_TIRE_KM_4: '',
      r_TIRE_KM_5: '',
      r_TIRE_KM_6: '',
      h_VICIVLE_BRANCHTYPE: '',



      // footer data ===========================
      f_DATEEXPRIED: '',
      f_CARD_NO: '',
      f_BRANCH: '',
      f_YEAR: '',
      f_GALATY_NO: '',
      f_GALATY_DEP: '',
      f_CAR_TYPE: '',

      truct_footer_data_list: [],
      bl_TRIES_1: '',
      bl_TRIES_2: '',
      bl_TRIES_3: '',
      bl_TRIES_4: '',
      bl_TRIES_5: '',
      bl_TRIES_6: '',
      bl_TRIES_7: '',
      bl_TRIES_8: '',

      br_TRIES_1: '',
      br_TRIES_2: '',
      br_TRIES_3: '',
      br_TRIES_4: '',
      br_TRIES_5: '',
      br_TRIES_6: '',
      br_TRIES_7: '',
      br_TRIES_8: '',
      bl_TRIES_DATE_1: '',
      bl_TRIES_DATE_2: '',
      bl_TRIES_DATE_3: '',
      bl_TRIES_DATE_4: '',
      bl_TRIES_DATE_5: '',
      bl_TRIES_DATE_6: '',
      bl_TRIES_DATE_7: '',
      bl_TRIES_DATE_8: '',


      br_TRIES_DATE_1: '',
      br_TRIES_DATE_2: '',
      br_TRIES_DATE_3: '',
      br_TRIES_DATE_4: '',
      br_TRIES_DATE_5: '',
      br_TRIES_DATE_6: '',
      br_TRIES_DATE_7: '',
      br_TRIES_DATE_8: '',

      bl_TRIES_KM_1: '',
      bl_TRIES_KM_2: '',
      bl_TRIES_KM_3: '',
      bl_TRIES_KM_4: '',
      bl_TRIES_KM_5: '',
      bl_TRIES_KM_6: '',
      bl_TRIES_KM_7: '',
      bl_TRIES_KM_8: '',


      br_TRIES_KM_1: '',
      br_TRIES_KM_2: '',
      br_TRIES_KM_3: '',
      br_TRIES_KM_4: '',
      br_TRIES_KM_5: '',
      br_TRIES_KM_6: '',
      br_TRIES_KM_7: '',
      br_TRIES_KM_8: '',

      // create report
      key_ID: '',
      staff_BIALIENG_FRIST: '',
      staff_BIALINEG_KANGJAIY: '',
      product_SIZE: '',
      product_DETAILS: '',
      product_FROM: '',
      customer_ID: '',
      product_ID: '',
      product_AMOUNT: '',
      product_TO: '',
      staff_BIALIENG: '',
      place_PD_TO: '',
      kongnarlod: '',
      laiyathang: '',
      numnuklod: '',
      kim_KILO: '',
      place_PD_FROM: '',
      out_DATE: '',
      staff_ID_NUM1: '',
      in_DATE: '',
      sainummun: '',
      footer_ID: '',
      header_ID: '',
      staff_ID_NUM2: '',
      khg_MUE_TIDLOD: '',


      test: ''
    }
  },
  watch: {
    product_price: function (newValue) {
      const real_total = parseInt(newValue?.split(',').join('')) * parseInt(this.product_weight ? this.product_weight?.split(',').join('') : 1);
      // const set_real_total = (real_total)?.toString().replace(/\D/g, '').replace(/\B(?=(\d{3})+(?!\d))/g, ',')
      this.total_price = (real_total).toString().replace(/\D/g, '').replace(/\B(?=(\d{3})+(?!\d))/g, ',');
      const result = newValue.replace(/\D/g, '').replace(/\B(?=(\d{3})+(?!\d))/g, ',')
      this.product_price = result
    },
    product_quality: function (newValue) {
      const real_total = parseInt(newValue?.split(',').join('')) * parseInt(this.product_price ? this.product_price?.split(',').join('') : 1);
      this.total_price = (real_total).toString().replace(/\D/g, '').replace(/\B(?=(\d{3})+(?!\d))/g, ',');
      const result = newValue.replace(/\D/g, '').replace(/\B(?=(\d{3})+(?!\d))/g, ',');
      this.product_quality = result;
    },
    product_weight: function (newValue) {
      const real_total = parseFloat(newValue) * parseFloat(this.product_price ? this.product_price?.split(',').join('') : 1);
      this.total_price = real_total?.toString()?.replace(/\D/g, '')?.replace(/\B(?=(\d{3})+(?!\d))/g, ',')
      // const result =  newValue?.toString()?.replace(/\D/g, '')?.replace(/\B(?=(\d{3})+(?!\d))/g, ',')
      this.product_weight = newValue
    },
    money: function (newValue) {
      const real_money = parseInt(newValue?.split(',').join('')) - parseInt(this.money_aready_pay ? this.money_aready_pay?.split(',').join('') : 0)
      this.money_still_pay = real_money?.toString()?.replace(/\D/g, '')
        .replace(/\B(?=(\d{3})+(?!\d))/g, ',')
      const result = newValue
        .replace(/\D/g, '')
        .replace(/\B(?=(\d{3})+(?!\d))/g, ',')
      this.money = result
    },
    money_aready_pay: function (newValue) {
      const real_money = parseInt(this.money?.split(',').join('')) - parseInt(newValue ? newValue?.split(',').join('') : 0)
      this.money_still_pay = real_money?.toString().replace(/\D/g, '').replace(/\B(?=(\d{3})+(?!\d))/g, ',')
      const result = newValue
        .replace(/\D/g, '')
        .replace(/\B(?=(\d{3})+(?!\d))/g, ',')
      this.money_aready_pay = result
    },
    money1: function (newValue) {
      const real_money = parseInt(newValue?.split(',').join('')) - parseInt(this.money_aready_pay1 ? this.money_aready_pay1?.split(',').join('') : 0)
      this.money_still_pay1 = real_money?.toString()?.replace(/\D/g, '')
        .replace(/\B(?=(\d{3})+(?!\d))/g, ',')
      const result = newValue
        .replace(/\D/g, '')
        .replace(/\B(?=(\d{3})+(?!\d))/g, ',')
      this.money1 = result
    },
    money_aready_pay1: function (newValue) {
      const real_money = parseInt(this.money1?.split(',').join('')) - parseInt(newValue ? newValue?.split(',').join('') : 0)
      this.money_still_pay1 = real_money?.toString().replace(/\D/g, '')?.replace(/\B(?=(\d{3})+(?!\d))/g, ',')

      const result = newValue
        .replace(/\D/g, '')
        .replace(/\B(?=(\d{3})+(?!\d))/g, ',')
      this.money_aready_pay1 = result
    },

    priceNamMun: function (newValue) {
      const debt = parseFloat(this.priceNamMun?.split(',').join('')) * parseFloat(this.truck_glass?.split(',').join(''))
      this.priceNamMun_Total = debt?.toString()?.replace(/\B(?=(\d{3})+(?!\d))/g, ',')

      const result = newValue.replace(/\D/g, '').replace(/\B(?=(\d{3})+(?!\d))/g, ',')
      this.priceNamMun = result
    },


    road_send_km: function (newValue) {
      const result = newValue
        .replace(/\D/g, '')
        .replace(/\B(?=(\d{3})+(?!\d))/g, ',')
      this.road_send_km = result
    },
    truck_glass: function (newValue) {
      const result = newValue
        .replace(/\D/g, '')
        .replace(/\B(?=(\d{3})+(?!\d))/g, ',')
      this.truck_glass = result
    },
    truck_weight: function (newValue) {
      const result = newValue
        .replace(/\D/g, '')
        .replace(/\B(?=(\d{3})+(?!\d))/g, ',')
      this.truck_weight = result
    },
    truck_kilomen: function (newValue) {
      const result = newValue
        .replace(/\D/g, '')
        .replace(/\B(?=(\d{3})+(?!\d))/g, ',')
      this.truck_kilomen = result
    },
  },
  mounted() {
    this.onGetTruckList()
    this.onGetEmployeeList()
    this.onGetLocationList()
    this.onGetCustomerList()
    this.onGetProductsList()
    this.onGetTruckFooter()
    const today = new Date()
    const date =
      today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate()
    this.current_date = date
    this.onGetLeaveNumber()
  },

  methods: {
    onGetLeaveNumber() {
      try {
        this.$axios.$post('/listInvoiceNo.service').then((data) => {
          console.log("inv:", data)
          this.leave_id_car = data?.data[0]?.lahud_POYLOD;
        })
      } catch (error) {
        console.log(error)
      }
    },
    onAskBeforePrintBill() {
      // this.print()
      if (!this.$refs.form.validate()) {
        swal.fire({
          icon: 'info',
          title: 'ແຈ້ງເຕືອນ',
          text: 'ກະລຸນາປ້ອນຂໍ້ມູນໃຫ້ຄົບ'
        })
        return;
      }
      swal
        .fire({
          title: 'ທ່ານຕ້ອງການພິມບິນແທ້ບໍ ?',
          icon: 'question',
          showCancelButton: true,
          allowOutsideClick: false,
          confirmButtonColor: '#3085d6',
          cancelButtonColor: '#d33',
          confirmButtonText: 'Yes',
          cancelButtonText: 'No'
        })
        .then((result) => {
          if (result.isConfirmed) {
            this.onCreateReports()
          }
        })
    },

    async onCreateReports() {
      // this.print()
      // return;
      if (!this.$refs.form.validate()) {
        swal.fire({
          icon: 'info',
          text: 'ກະລຸນາປ້ອນຂໍ້ມູນໃຫ້ຄົບ'
        })
        return;
      }
      if (!this.leave_id_car) {
        swal.fire({
          icon: 'info',
          text: 'ຕ້ອງມີລະຫັດປ່ອຍລົດ'
        })
        return;
      }
      try {
        this.loading_processing = true;
        let data = {
          laHud_poyLod: this.leave_id_car,
          staff_BIALIENG_FRIST: this.money,//
          staff_BIALIENG: this.money_aready_pay,//
          staff_BIALINEG_KANGJAIY: this.money_still_pay,//
          staff02_PayAll: this.money1,
          staff02_Beforepay: this.money_aready_pay1,
          staff02_Notpay: this.money_still_pay1,
          product_SIZE: this.product_weight,//
          product_DETAILS: this.product_detail,//
          product_FROM: this.detail_send,//
          customer_ID: this.customer_id,//
          product_ID: this.product_ID,//
          product_AMOUNT: this.product_quality,//
          product_TO: this.detail_recive,//
          place_PD_TO: this.place_PD_TO,//
          kongnarlod: this.start_camera,//
          laiyathang: this.road_send_km,//
          numnuklod: this.truck_weight,//
          kim_KILO: this.kim_KM,//
          place_PD_FROM: this.place_PD_FROM,//
          out_DATE: this.start_go_date,//
          staff_ID_NUM1: this.staff_ID_NUM1,//
          in_DATE: this.end_date,//
          sainummun: this.truck_glass,//
          footer_ID: this.footer_ID,//
          header_ID: this.header_ID,//
          staff_ID_NUM2: this.staff_ID_NUM2,//
          khg_MUE_TIDLOD: this.digital_with_car,//
          price: this.product_price,//
          totalPrice: this.total_price,
          priceNamMun: this.priceNamMun,
          currency: this.currency,
          staff_Curr: this.currency1,
          staff_Status01: this.money_still_pay == 0 ? 'done' : 'not-pay',
          staff_Status02: this.money_still_pay1 == 0 ? 'done' : 'not-pay',
        }
        console.log("send:", data)
        // return
        await this.$axios.$post('/saveDataDetails.service', data).then((data) => {
          console.log("createReport:", data)

          if (data?.status === '00') {
            this.loading_processing = false;
            this.onGetLeaveNumber();
            this.onGetTruckList();
            this.onGetTruckFooter();
            this.onGetEmployeeList()
            this.print();
          }
        })
      } catch (error) {
        console.log(error)
        this.loading_processing = false
      }
    },
    onGetTructFooterDetail(

      key_id
    ) {

      let data = this.truct_footer_data_list.filter((el => el.key_id === key_id));
      console.log("back:", data)
      this.f_DATEEXPRIED = data[0]?.f_DATEEXPRIED,
        this.f_CARD_NO = data[0]?.f_CARD_NO,
        this.f_BRANCH = data[0]?.f_BRANCH,
        this.f_YEAR = data[0]?.f_YEAR,
        this.f_GALATY_NO = data[0]?.f_GALATY_NO,
        this.f_GALATY_DEP = data[0]?.f_GALATY_DEP,
        this.f_CAR_TYPE = data[0]?.f_CAR_TYPE,
        this.f_LEKKUNZEE = data[0]?.f_LEKKUNZEE,

        this.bl_TRIES_1 = data[0]?.l_TRIES_1,
        this.bl_TRIES_2 = data[0]?.l_TRIES_2,
        this.bl_TRIES_3 = data[0]?.l_TRIES_3,
        this.bl_TRIES_4 = data[0]?.l_TRIES_4,
        this.bl_TRIES_5 = data[0]?.l_TRIES_5,
        this.bl_TRIES_6 = data[0]?.l_TRIES_6,
        this.bl_TRIES_7 = data[0]?.l_TRIES_7,
        this.bl_TRIES_8 = data[0]?.l_TRIES_8,

        this.br_TRIES_1 = data[0]?.r_TRIES_1,
        this.br_TRIES_2 = data[0]?.r_TRIES_2,
        this.br_TRIES_3 = data[0]?.r_TRIES_3,
        this.br_TRIES_4 = data[0]?.r_TRIES_4,
        this.br_TRIES_5 = data[0]?.r_TRIES_5,
        this.br_TRIES_6 = data[0]?.r_TRIES_6,
        this.br_TRIES_7 = data[0]?.r_TRIES_7,
        this.br_TRIES_8 = data[0]?.r_TRIES_8,
        this.bl_TRIES_DATE_1 = data[0]?.l_TRIES_DATE_1,
        this.bl_TRIES_DATE_2 = data[0]?.l_TRIES_DATE_2,
        this.bl_TRIES_DATE_3 = data[0]?.l_TRIES_DATE_3,
        this.bl_TRIES_DATE_4 = data[0]?.l_TRIES_DATE_4,
        this.bl_TRIES_DATE_5 = data[0]?.l_TRIES_DATE_5,
        this.bl_TRIES_DATE_6 = data[0]?.l_TRIES_DATE_6,
        this.bl_TRIES_DATE_7 = data[0]?.l_TRIES_DATE_7,
        this.bl_TRIES_DATE_8 = data[0]?.l_TRIES_DATE_8,


        this.br_TRIES_DATE_1 = data[0]?.r_TRIES_DATE_1,
        this.br_TRIES_DATE_2 = data[0]?.r_TRIES_DATE_2,
        this.br_TRIES_DATE_3 = data[0]?.r_TRIES_DATE_3,
        this.br_TRIES_DATE_4 = data[0]?.r_TRIES_DATE_4,
        this.br_TRIES_DATE_5 = data[0]?.r_TRIES_DATE_5,
        this.br_TRIES_DATE_6 = data[0]?.r_TRIES_DATE_6,
        this.br_TRIES_DATE_7 = data[0]?.r_TRIES_DATE_7,
        this.br_TRIES_DATE_8 = data[0]?.r_TRIES_DATE_8,

        this.bl_TRIES_KM_1 = data[0]?.l_TRIES_KM_1,
        this.bl_TRIES_KM_2 = data[0]?.l_TRIES_KM_2,
        this.bl_TRIES_KM_3 = data[0]?.l_TRIES_KM_3,
        this.bl_TRIES_KM_4 = data[0]?.l_TRIES_KM_4,
        this.bl_TRIES_KM_5 = data[0]?.l_TRIES_KM_5,
        this.bl_TRIES_KM_6 = data[0]?.l_TRIES_KM_6,
        this.bl_TRIES_KM_7 = data[0]?.l_TRIES_KM_7,
        this.bl_TRIES_KM_8 = data[0]?.l_TRIES_KM_8,


        this.br_TRIES_KM_1 = data[0]?.r_TRIES_KM_1,
        this.br_TRIES_KM_2 = data[0]?.r_TRIES_KM_2,
        this.br_TRIES_KM_3 = data[0]?.r_TRIES_KM_3,
        this.br_TRIES_KM_4 = data[0]?.r_TRIES_KM_4,
        this.br_TRIES_KM_5 = data[0]?.r_TRIES_KM_5,
        this.br_TRIES_KM_6 = data[0]?.r_TRIES_KM_6,
        this.br_TRIES_KM_7 = data[0]?.r_TRIES_KM_7,
        this.br_TRIES_KM_8 = data[0]?.r_TRIES_KM_8,

        this.footer_ID = key_id
    },
    async onGetCarDetails(
      id
    ) {
      console.log(id)

      let data = this.cars_list.filter((el => el.key_id === id));
      console.log('head:', data)
      this.h_VICIVLE_NUMBER = data[0]?.h_VICIVLE_NUMBER,
        this.h_VICIVLE_BRANCH = data[0]?.h_VICIVLE_BRANCH,
        this.h_VICIVLE_YEARLEVEL = data[0]?.h_VICIVLE_YEARLEVEL,
        this.h_VICIVLE_GALATY = data[0]?.h_VICIVLE_GALATY,
        this.h_VICIVLE_DATE_GALATY = data[0]?.h_VICIVLE_DATE_GALATY,
        this.h_VICIVLE_LEKJUK = data[0]?.h_VICIVLE_LEKJUK,
        this.h_VICIVLE_LEKTHUNG = data[0]?.h_VICIVLE_LEKTHUNG,
        this.h_VICIVLE_BRANCHTYPE = data[0]?.h_VICIVLE_BRANCHTYPE,
        this.h_VICIVLE_DATEEXPRIRE = data[0]?.h_VICIVLE_DATEEXPRIRE,
        this.kim_KM = data[0]?.kim_KM,
        this.ll_TIRE_NO_1 = data[0]?.ll_TIRE_NO_1,
        this.ll_TIRE_NO_2 = data[0]?.ll_TIRE_NO_2,
        this.ll_TIRE_NO_3 = data[0]?.ll_TIRE_NO_3,
        this.ll_TIRE_NO_4 = data[0]?.ll_TIRE_NO_4,
        this.ll_TIRE_NO_5 = data[0]?.ll_TIRE_NO_5,
        this.ll_TIRE_NO_6 = data[0]?.ll_TIRE_NO_6,

        this.r_TIRE_NO_1 = data[0]?.r_TIRE_NO_1,
        this.r_TIRE_NO_2 = data[0]?.r_TIRE_NO_2,
        this.r_TIRE_NO_3 = data[0]?.r_TIRE_NO_3,
        this.r_TIRE_NO_4 = data[0]?.r_TIRE_NO_4,
        this.r_TIRE_NO_5 = data[0]?.r_TIRE_NO_5,
        this.r_TIRE_NO_6 = data[0]?.r_TIRE_NO_6,

        this.ll_TIRE_DATE_1 = data[0]?.ll_TIRE_DATE_1,
        this.ll_TIRE_DATE_2 = data[0]?.ll_TIRE_DATE_2,
        this.ll_TIRE_DATE_3 = data[0]?.ll_TIRE_DATE_3,
        this.ll_TIRE_DATE_4 = data[0]?.ll_TIRE_DATE_4,
        this.ll_TIRE_DATE_5 = data[0]?.ll_TIRE_DATE_5,
        this.ll_TIRE_DATE_6 = data[0]?.ll_TIRE_DATE_6,

        this.r_TIRE_DATE_1 = data[0]?.r_TIRE_DATE_1,
        this.r_TIRE_DATE_2 = data[0]?.r_TIRE_DATE_2,
        this.r_TIRE_DATE_3 = data[0]?.r_TIRE_DATE_3,
        this.r_TIRE_DATE_4 = data[0]?.r_TIRE_DATE_4,
        this.r_TIRE_DATE_5 = data[0]?.r_TIRE_DATE_5,
        this.r_TIRE_DATE_6 = data[0]?.r_TIRE_DATE_6,

        this.ll_TIRE_KM_1 = data[0]?.ll_TIRE_KM_1,
        this.ll_TIRE_KM_2 = data[0]?.ll_TIRE_KM_2,
        this.ll_TIRE_KM_3 = data[0]?.ll_TIRE_KM_3,
        this.ll_TIRE_KM_4 = data[0]?.ll_TIRE_KM_4,
        this.ll_TIRE_KM_5 = data[0]?.ll_TIRE_KM_5,
        this.ll_TIRE_KM_6 = data[0]?.ll_TIRE_KM_6,

        this.r_TIRE_KM_1 = data[0]?.r_TIRE_KM_1,
        this.r_TIRE_KM_2 = data[0]?.r_TIRE_KM_2,
        this.r_TIRE_KM_3 = data[0]?.r_TIRE_KM_3,
        this.r_TIRE_KM_4 = data[0]?.r_TIRE_KM_4,
        this.r_TIRE_KM_5 = data[0]?.r_TIRE_KM_5,
        this.r_TIRE_KM_6 = data[0]?.r_TIRE_KM_6,
        this.let_mai_pian_num_mun_kheng_next = data[0]?.h_LEK_NUMMUNKHG,
        this.header_ID = id
      this.let_mai_pian_num_mun_kheng_next = data[0]?.h_LEK_NUMMUNKHG,
        this.header_ID = id
    },
    print() {
      const modal = document.getElementById("modalInvoice")
      const cloned = modal.cloneNode(true)
      let section = document.getElementById("print")
      if (!section) {
        section = document.createElement("div")
        section.id = "print"
        document.body.appendChild(section)
      }
      section.innerHTML = "";
      section.appendChild(cloned);
      window.print();
    },

    onClearData() {
      this.Id_lea_cars = ''
      this.truck_plateNo = ''
      this.truck_plate_detail = ''
      this.truck_type = ''
      this.emp_name = ''
      this.emp_mobile = ''
      this.pri_id_card = ''
      this.product_name = ''
      this.pri_product_details = ''
      this.pri_product_qty = ''
      this.loca_detail = ''
      this.loca_detail1 = ''
      this.loca_province = ''
      this.loca_province1 = ''
      this.pri_road_express = ''
      this.pri_card_glass = ''
      this.price = ''
      this.start_go_date = null
      this.end_date = null
      this.pri_money_allready_pay = '0'
      this.customer_id = ''
      this.customer_mobile = ''
      this.customer_name = ''
      this.pri_express_prod_detail = ''
      this.pri_recive_prod_detail = ''
      this.pri_car_brand = ''
      this.pri_product_weight = ''
    },
    activate() {
      setTimeout(() => this.print(), 1000)
    },
    onGetCustomerDetails(id) {
      console.log(id)
      let data = this.customer_data_list.filter((el => el.id === id));
      // console.log("filter:",data)
      this.customer_name = data[0]?.customerName
      this.customer_mobile = data[0]?.mobile
      this.customer_id = id
    },
    onGetEmpDetails(id) {
      let data = this.emplyee_list.filter((el => el.id === id));
      this.emp_name = data[0]?.realName
      this.emp_mobile = data[0]?.phone
      this.emp_id_card = data[0]?.cardNo
      this.staff_ID_NUM1 = data[0]?.id
    },
    onGetEmpDetails1(id) {
      let data = this.emplyee_list.filter((el => el.id === id));
      this.emp_name1 = data[0]?.realName
      this.emp_mobile1 = data[0]?.phone
      this.emp_id_card1 = data[0]?.cardNo
      this.staff_ID_NUM2 = data[0]?.id
    },

    async onGetTruckList() {
      try {
        this.loading_processing = true
        await this.$axios.$post('listVicicleHeaderCombo1.service').then((data) => {
          console.log('truck_list:', data?.data)
          this.cars_list = data?.data

        })
      } catch (error) {
        this.loading_processing = false
        console.log(error)
        swal.fire({
          title: 'ແຈ້ງເຕືອນ',
          text: error,
          icon: 'error',
          allowOutsideClick: false,
          confirmButtonColor: '#3085d6',
          confirmButtonText: 'OK',
        })
      }
    },
    async onGetTruckFooter() {
      try {
        this.loading_processing = true
        await this.$axios.$post('listViciclefooterCombo1.service').then((data) => {
          console.log('all_truck_footer_list:', data)
          if (data?.data == null || data?.data == '') {
            this.truct_footer_data_list = []
            this.loading_processing = false
            this.loading_processing = false
          } else {
            this.truct_footer_data_list = data?.data
            this.loading_processing = false
            this.loading_processing = false
          }
        })
      } catch (error) {
        this.loading_processing = false
        console.log(error)
        swal.fire({
          title: 'ແຈ້ງເຕືອນ',
          text: error,
          icon: 'error',
          allowOutsideClick: false,
          confirmButtonColor: '#3085d6',
          confirmButtonText: 'OK',
        })
      }
    },
    async onGetEmployeeList() {
      try {
        this.loading_processing = true
        await this.$axios.$post('getChooseStaft01.service').then((data) => {
          console.log('employee_list:', data?.data)
          // this.emplyee_list = data?.data
          this.emplyee_list = data?.data?.map((list) => {
            return {
              'name': `${list?.name} | ${list?.surname}`, 'phone': `${list?.mobile}`, 'cardNo': `${list?.idCard}`, 'id': `${list?.id
                }`, 'st_id': `${list?.staftId}`, 'realName': `${list?.name}`
            }
          })
        })
      } catch (error) {
        this.loading_processing = false
        console.log(error)
        swal.fire({
          title: 'ແຈ້ງເຕືອນ',
          text: error,
          icon: 'error',
          allowOutsideClick: false,
          confirmButtonColor: '#3085d6',
          confirmButtonText: 'OK',
        })
      }
    },
    onGetLocaDetails(id) {
      let data = this.loca_data_list.filter((el => el.id === id));

      this.loca_send_province = data[0]?.province
      this.loca_send_station = data[0]?.detail
      this.place_PD_FROM = id
    },
    onGetLocaDetails1(id) {
      let data = this.loca_data_list.filter((el => el.id === id));
      this.loca_recieve_province = data[0]?.province
      this.loca_revieve_station = data[0]?.detail
      this.place_PD_TO = id
    },
    onGetProductDetails(id) {

      let data = this.products_data_list.filter((el => el.id === id));
      this.product_name = data[0]?.proName;
      this.product_ID = id;
    },
    async onGetLocationList() {
      try {
        // this.loading_processing = true
        await this.$axios.$post('/getAllLocation').then((data) => {
          if (data?.status == '00') {
            // this.loading_processing = false
            console.log('locaList:', data)
            // this.loca_data_list = data?.data
            this.loca_data_list = data?.data.map((list) => {
              return { 'name': `${list?.province} | ${list?.detail}`, 'id': `${list?.id}`, 'detail': `${list?.detail}`, 'province': `${list?.province}` };
            })
          }
        })
      } catch (error) {
        // this.loading_processing = false
        swal.fire({
          title: 'ແຈ້ງເຕືອນ',
          text: error,
          icon: 'error',
          allowOutsideClick: false,
          confirmButtonColor: '#3085d6',
          confirmButtonText: 'OK',
        })
      }
    },
    async onGetCustomerList() {
      try {
        this.loading_processing = true
        await this.$axios.$post('getAllCustomer').then((data) => {
          if (data?.status == '00') {
            this.customer_data_list = data?.data
            this.loading_processing = false
            console.log('customer_list:', data)
          }
        })
      } catch (error) {
        this.loading_processing = false
        console.log(error)
        swal.fire({
          title: 'ແຈ້ງເຕືອນ',
          text: error,
          icon: 'error',
          allowOutsideClick: false,
          confirmButtonColor: '#3085d6',
          confirmButtonText: 'OK',
        })
      }
    },
    async onGetProductsList() {
      try {
        this.loading_processing = true
        await this.$axios.$post('getAllProduct').then((data) => {
          if (data?.status == '00') {
            this.products_data_list = data?.data
            this.loading_processing = false
            console.log('products_list:', data)
          }
        })
      } catch (error) {
        this.loading_processing = false
        swal.fire({
          title: 'ແຈ້ງເຕືອນ',
          text: error,
          icon: 'error',
          allowOutsideClick: false,
          confirmButtonColor: '#3085d6',
          confirmButtonText: 'OK',
        })
      }
    },
  },
}
</script>
<style lang="scss">
.bottoms {
  position: relative;
  bottom: 0px;
}

// @media print {
//   .page {
//     margin: 0;
//     border: initial;
//     border-radius: initial;
//     width: initial;
//     min-height: initial;
//     box-shadow: initial;
//     background: initial;
//     overflow: visible;
//   }

//   .printonly {
//     page-break-before: always;
//     color: #000000;
//   }

//   .noprint {
//     display: none;
//   }
// }


@media screen {
  #print {
    display: none;
  }
}

@media print {
  @page {
    size: A4;
    margin: 1in;
  }

  body * {
    visibility: hidden;
  }

  #print,
  #print * {
    visibility: visible;
  }

  #print {
    position: absolute;
    top: 0px;
    right: 0px;
    left: 0px;
  }
}

.margintop {
  margin-top: -30px;
}

.top {
  margin-top: 5px;
  margin-left: 10px;
}
</style>
