<template>
    <div>
        <v-dialog v-model="loading_processing" persistent width="55">
            <v-card width="55" height="55" class="pt-3 pl-3">
                <v-progress-circular :width="3" color="primary" indeterminate></v-progress-circular>
            </v-card>
        </v-dialog>
        <!-- General car info -->
        <v-card color="pl-10 pr-10" class="card-shadow">

            <v-form v-model="valid" ref="form" lazy-validation>
                <!-- ຂໍ້ມູນຫົວລົດ================== -->
                <v-card flat>
                    <div class="pa-2 pl-6 pt-4 d-flex">
                        <v-btn fab dark elevation="0" width="40" height="40" color="#338ABF" to="cars_14">
                            <v-icon color="white">mdi-arrow-left</v-icon>
                        </v-btn>
                        <h3 class="top">ເບີ່ງຂໍ້ມູນຫົວລົດ</h3>
                        <v-spacer></v-spacer>
                        <div v-if="alert === true"
                            style="border:1px solid red;height:40px;border-radius:3px;display:flex;align-items:center"
                            class="ml-2 pl-2 pr-10 mr-4">
                            <v-icon color="red">mdi-alert-outline</v-icon>
                            <span class="ml-2 red--text">ນໍ້າມັນເຄື່ອງໝົດກຳນົດແລ້ວ!</span>
                        </div>
                    </div>

                    <v-card-text>
                        <div class="" style="display:flex;flex-direction:row;justify-content:space-between">

                            <div style="width:100%" class="px-2">
                                <span>ທະບຽນລົດ</span>
                                <v-text-field label="ທະບຽນລົດ" dense flat solo background-color="#f5f5f5" readonly
                                    v-model="h_VICIVLE_NUMBER"></v-text-field>
                            </div>
                            <div class="px-2" style="width:100%">
                                <span>ປະກັນໄພ</span>
                                <v-text-field label="ປະກັນໄພ" dense flat solo background-color="#f5f5f5" readonly
                                    v-model="h_VICIVLE_GALATY"></v-text-field>
                            </div>
                            <div class="px-2" style="width:100%">
                                <span>ວັນທີປະກັນໄພໝົດ</span>
                                <v-text-field label="ວັນທີປະກັນໄພໝົດ" dense flat solo background-color="#f5f5f5" readonly
                                    v-model="h_VICIVLE_DATE_GALATY"></v-text-field>
                            </div>
                            <div class="px-2" style="width:100%">
                                <span>ເຂັມກີໂລແມັດ</span>

                                <v-text-field label="ເຂັມກີໂລແມັດ" dense flat solo readonly v-model="kim_KM"
                                    :background-color="alert === true ? 'red' : '#f5f5f5'"></v-text-field>
                            </div>

                        </div>
                        <div class="d-flex align-center">

                            <div style="width:100%" class="px-2"><span>ຍີ່ຫໍ້ລົດ</span>
                                <v-text-field label="ຍີ່ຫໍ້ລົດ" dense flat solo background-color="#f5f5f5" readonly
                                    v-model="h_VICIVLE_BRANCH"></v-text-field>
                            </div>
                            <div style="width:100%" class="px-2"><span>ລົດປີ</span>
                                <v-text-field label="ລົດປີ" dense flat solo background-color="#f5f5f5" readonly
                                    v-model="h_VICIVLE_YEARLEVEL"></v-text-field>
                            </div>
                            <div style="width:100%" class="px-2"><span>ປະເພດລົດ</span>
                                <v-text-field label="ປະເພດລົດ" dense flat solo background-color="#f5f5f5" readonly
                                    v-model="h_VICIVLE_BRANCHTYPE"></v-text-field>
                            </div>
                            <div style="width:100%" class="px-2"><span>ເລກໄມປ່ຽນນໍ້າມັນເຄື່ອງຮອບຕໍ່ໄປ</span>
                                <v-text-field label="ເລກໄມປ່ຽນນໍ້າມັນເຄື່ອງຮອບຕໍ່ໄປ" dense flat solo readonly
                                    v-model="h_LEK_NUMMUNKHG"
                                    :background-color="alert === true ? 'red' : '#f5f5f5'"></v-text-field>
                            </div>
                        </div>
                        <div class="" style="display:flex;flex-direction:row;justify-content:space-between">

                            <div style="width:100%" class="px-2"><span>ເລກຈັກ</span>
                                <v-text-field label="ເລກຈັກ" dense flat solo background-color="#f5f5f5" readonly
                                    v-model="h_VICIVLE_LEKJUK"></v-text-field>
                            </div>
                            <div class="px-2" style="width:100%"><span>ເລກຖັງ</span><v-text-field label="ເລກຖັງ" dense
                                    flat solo background-color="#f5f5f5" readonly
                                    v-model="h_VICIVLE_LEKTHUNG"></v-text-field></div>
                            <div class="px-2" style="width:100%"><span>GPS</span><v-text-field label="GPS" dense flat
                                    solo background-color="#f5f5f5" readonly v-model="h_VICIVLE_GPS"></v-text-field></div>
                            <div class="px-2" style="width:100%"><span>ຝອຍປັດນໍ້າຝົນ</span><v-text-field label="ຝອຍປັດນໍ້າຝົນ"
                                    dense flat solo background-color="#f5f5f5" readonly
                                    v-model="h_VICIVLE_POYPUDNUMFON"></v-text-field>
                            </div>

                        </div>
                        <div class="" style="display:flex;flex-direction:row;justify-content:space-between">

                            <div style="width:100%" class="px-2"><span>ໝໍ້ໄຟ</span>
                                <v-text-field label="ໝໍ້ໄຟ" dense flat solo background-color="#f5f5f5" readonly
                                    v-model="h_VICIVLE_MORFAI"></v-text-field>
                            </div>
                            <div class="px-2" style="width:100%"><span>ບັງຕົມ</span><v-text-field label="ບັງຕົມ" dense
                                    flat solo background-color="#f5f5f5" readonly v-model="h_VICIVLE_BGTOM"></v-text-field>
                            </div>
                            <div class="px-2" style="width:100%"><span>ຈານລາກ</span><v-text-field label="ຈານລາກ" dense
                                    flat solo background-color="#f5f5f5" readonly
                                    v-model="h_VICIVLE_JANLARK"></v-text-field></div>
                            <div class="px-2" style="width:100%"><span>ໄຟໜ້າ</span><v-text-field label="ໄຟໜ້າ" dense flat
                                    solo background-color="#f5f5f5" readonly v-model="h_VICIVLE_FAINAR"></v-text-field>
                            </div>

                        </div>
                        <div class="" style="display:flex;flex-direction:row;justify-content:space-between">

                            <div style="width:100%" class="px-2"><span>ໄຟທ້າຍ</span>
                                <v-text-field label="ໄຟທ້າຍ" dense flat solo background-color="#f5f5f5" readonly
                                    v-model="h_VICIVLE_FAITHAIY"></v-text-field>
                            </div>
                            <div class="px-2" style="width:100%"><span>ໄຟຂ້າງ</span><v-text-field label="ໄຟຂ້າງ" dense
                                    flat solo background-color="#f5f5f5" readonly
                                    v-model="h_VICIVLE_FAIYKHANG"></v-text-field></div>
                            <div class="px-2" style="width:100%"><span>ແວ່ນມອງໜ້າ</span><v-text-field label="ແວ່ນມອງໜ້າ" dense
                                    flat solo background-color="#f5f5f5" readonly
                                    v-model="h_VICIVLE_VENMONGNAR"></v-text-field></div>
                            <div class="px-2" style="width:100%"><span>ແວ່ນມອງຫຼັງ</span><v-text-field label="ແວ່ນມອງຫຼັງ"
                                    dense flat solo background-color="#f5f5f5" readonly
                                    v-model="h_VICIVLE_VENMONGLHG"></v-text-field></div>

                        </div>
                        <div class="" style="display:flex;flex-direction:row;justify-content:space-between">

                            <div style="width:100%" class="px-2"><span>ແວ່ນຂ້າງ</span>
                                <v-text-field label="ແວ່ນຂ້າງ" dense flat solo background-color="#f5f5f5" readonly
                                    v-model="h_VICIVLE_VENKHANG"></v-text-field>
                            </div>

                        </div>


                        <div class="margintop d-flex align-center mt-4">

                            <div class="d-flex align-center pt-2 ml-2 pr-2"
                                style="background-color:#f7f7f7;border-radius:5px;height:40px">
                                <v-radio-group inline v-model="h_VICIVLE_GLASS">
                                    <div class="pl-4 d-flex align-center">
                                        <span>ນໍ້າມັນລົດໃຊ້</span>
                                        <Width />
                                        <v-radio label="ແອັດຊັງ" value="ແອັດຊັງ"></v-radio>
                                        <Width />
                                        <v-radio label="ກະຊວນ" value="ກະຊວນ"></v-radio>
                                    </div>
                                </v-radio-group>
                            </div>

                            <div class="d-flex align-center pt-2 ml-2 pr-2"
                                style="background-color:#f7f7f7;border-radius:5px;height:40px">
                                <v-radio-group inline v-model="h_STATUS">
                                    <div class="pl-4 d-flex align-center">
                                        <span>ສະຖານະລົດ</span>
                                        <Width />
                                        <v-radio label="ວ່າງ" value="Y" color="#55CE63"></v-radio>
                                        <Width />
                                        <v-radio label="ບໍ່ວ່າງ" value="N" color="red"></v-radio>
                                    </div>
                                </v-radio-group>
                            </div>
                        </div>
                    </v-card-text>
                </v-card>

                <!-- ຂໍ້ມູນຢາງລົດ -->
                <v-card flat>

                    <v-card-text class="px-7">
                        <div class="d-flex">
                            <span style="font-size:14pt">ຂໍ້ມູນຢາງລົດ:</span>
                        </div>
                        <div class="d-flex">
                            <div style="width:100%">

                                <!-- Left -->
                                <div style="background-color:#f5f5f5;height:85px;padding-top:5px;border-radius:5px"
                                    class="px-2">
                                    <div class="d-flex pt-1">
                                        <v-text-field   flat dense label="ລະຫັດຢາງລົດ"
                                            v-model="ll_TIRE_NO_1"></v-text-field>

                                        <v-text-field class="ml-2" dense  flat label="ວັນທີປ່ຽນຢາງ"
                                            v-model="ll_TIRE_DATE_1"></v-text-field>
                                        <v-text-field class="ml-2" dense   flat label="ກຳນົດແລ່ນໄດ້ km"
                                            v-model="ll_TIRE_KM_1"></v-text-field>
                                    </div>
                                    <div class="d-flex">
                                        <v-text-field style="margin-top:0px"    flat dense
                                            label="ເລກໄມລ່າສຸດ" v-model="h_KM1"></v-text-field>
                                        <v-text-field style="margin-top:0px" class="ml-2"   flat dense
                                            label="ເລກໄມປະຈຸບັນ" v-model="h_KML_1"></v-text-field>

                                    </div>
                                </div>
                                <div style="background-color:#f5f5f5;height:80px;padding-top:5px;border-radius:5px"
                                    class="px-2 mt-1 pt-1" v-if="ll_TIRE_NO_2">
                                    <div class="d-flex">
                                        <v-text-field  dense  flat label="ລະຫັດຢາງລົດ"
                                            v-model="ll_TIRE_NO_2"></v-text-field>
                                        <v-text-field class="ml-2" dense  flat label="ວັນທີປ່ຽນຢາງ"
                                            v-model="ll_TIRE_DATE_2"></v-text-field>
                                        <v-text-field class="ml-2" dense  flat label="ກຳນົດແລ່ນໄດ້ km"
                                            v-model="ll_TIRE_KM_2"></v-text-field>
                                    </div>
                                    <div class="d-flex" style="margin-top:-10px">
                                        <v-text-field  dense  flat label="ເລກໄມລ່າສຸດ"
                                            v-model="h_KM2"></v-text-field>
                                        <v-text-field class="ml-2" dense  flat label="ເລກໄມປະຈຸບັນ"
                                            v-model="h_KML_2"></v-text-field>
                                    </div>
                                </div>
                                <div style="background-color:#f5f5f5;height:80px;padding-top:5px;border-radius:5px"
                                    class="px-2 mt-1">
                                    <div class="d-flex pt-1">
                                        <v-text-field  dense  flat label="ລະຫັດຢາງລົດ"
                                            v-model="ll_TIRE_NO_3"></v-text-field>
                                        <v-text-field class="ml-2" dense  flat label="ວັນທີປ່ຽນຢາງ"
                                            v-model="ll_TIRE_DATE_3"></v-text-field>
                                        <v-text-field class="ml-2" dense  flat label="ກຳນົດແລ່ນໄດ້ km"
                                            v-model="ll_TIRE_KM_3"></v-text-field>
                                    </div>
                                    <div class="d-flex" style="margin-top:-10px">
                                        <v-text-field  dense  flat label="ເລກໄມລ່າສຸດ"
                                            v-model="h_KM3"></v-text-field>
                                        <v-text-field class="ml-2" dense  flat label="ເລກໄມປະຈຸບັນ"
                                            v-model="h_KML_3"></v-text-field>
                                    </div>
                                </div>
                                <div style="background-color:#f5f5f5;height:80px;padding-top:5px;border-radius:5px"
                                    class="px-2 mt-1 pt-2">
                                    <div class="d-flex">
                                        <v-text-field  dense  flat label="ລະຫັດຢາງລົດ"
                                            v-model="ll_TIRE_NO_4"></v-text-field>

                                        <v-text-field class="ml-2" dense  flat label="ວັນທີປ່ຽນຢາງ"
                                            v-model="ll_TIRE_DATE_4"></v-text-field>
                                        <v-text-field class="ml-2" dense  flat label="ກຳນົດແລ່ນໄດ້ km"
                                            v-model="ll_TIRE_KM_4"></v-text-field>
                                    </div>
                                    <div class="d-flex" style="margin-top:-10px">
                                        <v-text-field  dense  flat label="ເລກໄມລ່າສຸດ"
                                            v-model="h_KM4"></v-text-field>
                                        <v-text-field class="ml-2" dense  flat label="ເລກໄມປະຈຸບັນ"
                                            v-model="h_KML_4"></v-text-field>
                                    </div>
                                </div>
                                <div style="background-color:#f5f5f5;height:80px;padding-top:5px;border-radius:5px"
                                    class="px-2 mt-1 pt-2">
                                    <div style="padding-top: 0px" class="d-flex">
                                        <v-text-field  dense  flat label="ລະຫັດຢາງລົດ"
                                            v-model="ll_TIRE_NO_5"></v-text-field>

                                        <v-text-field class="ml-2" dense  flat label="ວັນທີປ່ຽນຢາງ"
                                            v-model="ll_TIRE_DATE_5"></v-text-field>
                                        <v-text-field class="ml-2" dense  flat label="ກຳນົດແລ່ນໄດ້ km"
                                            v-model="ll_TIRE_KM_5"></v-text-field>
                                    </div>
                                    <div class="d-flex" style="margin-top:-10px">
                                        <v-text-field  dense  flat label="ເລກໄມລ່າສຸດ"
                                            v-model="h_KM5"></v-text-field>
                                        <v-text-field class="ml-2" dense  flat label="ເລກໄມປະຈຸບັນ"
                                            v-model="h_KML_5"></v-text-field>
                                    </div>
                                </div>
                                <div style="background-color:#f5f5f5;height:80px;padding-top:5px;border-radius:5px"
                                    class="px-2 mt-1 pt-2">
                                    <div class="d-flex">
                                        <v-text-field  dense  flat label="ລະຫັດຢາງລົດ"
                                            v-model="ll_TIRE_NO_6"></v-text-field>

                                        <v-text-field class="ml-2" dense  flat label="ວັນທີປ່ຽນຢາງ"
                                            v-model="ll_TIRE_DATE_6"></v-text-field>
                                        <v-text-field class="ml-2" dense  flat label="ກຳນົດແລ່ນໄດ້ km"
                                            v-model="ll_TIRE_KM_6"></v-text-field>
                                    </div>
                                    <div class="d-flex" style="margin-top:-10px">
                                        <v-text-field  dense  flat label="ເລກໄມລ່າສຸດ"
                                            v-model="h_KM6"></v-text-field>
                                        <v-text-field class="ml-2" dense  flat label="ເລກໄມປະຈຸບັນ"
                                            v-model="h_KML_6"></v-text-field>
                                    </div>
                                </div>
                            </div>

                            <div class="text-center">
                                <img v-if="r_TIRE_NO_2" class="mx-auto" src="../assets/images/head12.png" width="150"
                                    height="450" />
                                <img v-else class="mx-auto" src="../assets/images/head10.png" width="150" height="390" />
                            </div>

                            <!-- Right -->
                            <div style="width:100%">
                                <div style="background-color:#f5f5f5;height:80px;padding-top:5px;border-radius:5px"
                                    class="px-2 pt-2">
                                    <div class="d-flex">
                                        <v-text-field  dense  flat label="ລະຫັດຢາງລົດ"
                                            v-model="r_TIRE_NO_1"></v-text-field>

                                        <v-text-field class="ml-2" dense  flat label="ວັນທີປ່ຽນຢາງ"
                                            v-model="r_TIRE_DATE_1"></v-text-field>
                                        <v-text-field class="ml-2" dense  flat label="ກຳນົດແລ່ນໄດ້ km"
                                            v-model="r_TIRE_KM_1"></v-text-field>
                                    </div>
                                    <div class="d-flex" style="margin-top:-10px">
                                        <v-text-field  dense  flat label="ເລກໄມລ່າສຸດ"
                                            v-model="h_KM7"></v-text-field>
                                        <v-text-field class="ml-2" dense  flat label="ເລກໄມປະຈຸບັນ"
                                            v-model="h_KML_7"></v-text-field>
                                    </div>
                                </div>
                                <!-- =========12 los========== -->
                                <div v-if="r_TIRE_NO_2"
                                    style="background-color:#f5f5f5;height:80px;padding-top:0px;border-radius:5px"
                                    class="px-2 mt-1">
                                    <div class="d-flex pt-2">
                                        <v-text-field  dense  flat label="ລະຫັດຢາງລົດ"
                                            v-model="r_TIRE_NO_2"></v-text-field>

                                        <v-text-field class="ml-2" dense  flat label="ວັນທີປ່ຽນຢາງ"
                                            v-model="r_TIRE_DATE_2"></v-text-field>
                                        <v-text-field class="ml-2" dense  flat label="ກຳນົດແລ່ນໄດ້ km"
                                            v-model="r_TIRE_KM_2"></v-text-field>
                                    </div>
                                    <div class="d-flex" style="margin-top:-10px">
                                        <v-text-field  dense  flat label="ເລກໄມລ່າສຸດ"
                                            v-model="h_KM8"></v-text-field>
                                        <v-text-field class="ml-2" dense  flat label="ເລກໄມປະຈຸບັນ"
                                            v-model="h_KML_8"></v-text-field>
                                    </div>
                                </div>

                                <!-- /////////////////////////////// -->
                                <div style="background-color:#f5f5f5;height:80px;padding-top:5px;border-radius:5px"
                                    class="px-2 mt-1">
                                    <div class="d-flex pt-1">
                                        <v-text-field  dense  flat label="ລະຫັດຢາງລົດ"
                                            v-model="r_TIRE_NO_3"></v-text-field>

                                        <v-text-field class="ml-2" dense  flat label="ວັນທີປ່ຽນຢາງ"
                                            v-model="r_TIRE_DATE_3"></v-text-field>
                                        <v-text-field class="ml-2" dense  flat label="ກຳນົດແລ່ນໄດ້ km"
                                            v-model="r_TIRE_KM_3"></v-text-field>
                                    </div>
                                    <div class="d-flex" style="margin-top:-10px">
                                        <v-text-field  dense  flat label="ເລກໄມລ່າສຸດ"
                                            v-model="h_KM9"></v-text-field>
                                        <v-text-field class="ml-2" dense  flat label="ເລກໄມປະຈຸບັນ"
                                            v-model="h_KML_9"></v-text-field>
                                    </div>
                                </div>
                                <div style="background-color:#f5f5f5;height:80px;padding-top:5px;border-radius:5px"
                                    class="px-2 mt-1 pt-2">
                                    <div class="d-flex">
                                        <v-text-field  dense  flat label="ລະຫັດຢາງລົດ"
                                            v-model="r_TIRE_NO_4"></v-text-field>

                                        <v-text-field class="ml-2" dense  flat label="ວັນທີປ່ຽນຢາງ"
                                            v-model="r_TIRE_DATE_4"></v-text-field>
                                        <v-text-field class="ml-2" dense  flat label="ກຳນົດແລ່ນໄດ້ km"
                                            v-model="r_TIRE_KM_4"></v-text-field>
                                    </div>
                                    <div class="d-flex" style="margin-top:-10px">
                                        <v-text-field  dense  flat label="ເລກໄມລ່າສຸດ"
                                            v-model="h_KM10"></v-text-field>
                                        <v-text-field class="ml-2" dense  flat label="ເລກໄມປະຈຸບັນ"
                                            v-model="h_KML_10"></v-text-field>
                                    </div>
                                </div>
                                <div style="background-color:#f5f5f5;height:80px;padding-top:5px;border-radius:5px"
                                    class="px-2 pt-2 mt-1 ">
                                    <div class="d-flex">
                                        <v-text-field  dense  flat label="ລະຫັດຢາງລົດ"
                                            v-model="r_TIRE_NO_5"></v-text-field>

                                        <v-text-field class="ml-2" dense  flat label="ວັນທີປ່ຽນຢາງ"
                                            v-model="r_TIRE_DATE_5"></v-text-field>
                                        <v-text-field class="ml-2" dense  flat label="ກຳນົດແລ່ນໄດ້ km"
                                            v-model="r_TIRE_KM_5"></v-text-field>
                                    </div>
                                    <div class="d-flex" style="margin-top:-10px">
                                        <v-text-field  dense  flat label="ເລກໄມລ່າສຸດ"
                                            v-model="h_KM11"></v-text-field>
                                        <v-text-field class="ml-2" dense  flat label="ເລກໄມປະຈຸບັນ"
                                            v-model="h_KML_11"></v-text-field>
                                    </div>
                                </div>
                                <div style="background-color:#f5f5f5;height:80px;padding-top:5px;border-radius:5px"
                                    class="px-2 mt-1 pt-2">
                                    <div class="d-flex">
                                        <v-text-field  dense  flat label="ລະຫັດຢາງລົດ"
                                            v-model="r_TIRE_NO_6"></v-text-field>
                                        <v-text-field class="ml-2" dense  flat label="ວັນທີປ່ຽນຢາງ"
                                            v-model="r_TIRE_DATE_6"></v-text-field>
                                        <v-text-field class="ml-2" dense  flat label="ກຳນົດແລ່ນໄດ້ km"
                                            v-model="r_TIRE_KM_6"></v-text-field>
                                    </div>
                                    <div class="d-flex" style="margin-top:-10px">
                                        <v-text-field  dense  flat label="ເລກໄມລ່າສຸດ"
                                            v-model="h_KM12"></v-text-field>
                                        <v-text-field class="ml-2" dense  flat label="ເລກໄມປະຈຸບັນ"
                                            v-model="h_KML_12"></v-text-field>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </v-card-text>
                </v-card>

            </v-form>

            <Height />
            <Height />
            <Height />
        </v-card>
        <Height />
        <Height />
        <Height />
    </div>
</template>
<script>
import swal from 'sweetalert2'
export default {
    data() {
        return {
            alert: false,
            loading_processing: false,
            chooseCarType: '10',
            valid: true,
            nameRules: [(v) => !!v || ''],
            // state save data
            his_REASON: '',
            h_VICIVLE_GLASS: 'ກະຊວນ',
            h_VICIVLE_NUMBER: '',
            h_VICIVLE_GALATY: '',
            h_VICIVLE_DATE_GALATY: '',
            h_VICIVLE_TNGLOD: '',
            h_VICIVLE_BRANCH: '',
            h_VICIVLE_YEARLEVEL: '',
            h_VICIVLE_BRANCHTYPE: '',
            h_VICIVLE_DATEEXPRIRE: '',
            h_VICIVLE_LEKJUK: '',
            h_VICIVLE_LEKTHUNG: '',
            h_VICIVLE_GPS: '',
            h_VICIVLE_POYPUDNUMFON: '',
            h_VICIVLE_MORFAI: '',
            h_VICIVLE_BGTOM: '',
            h_VICIVLE_JANLARK: '',
            h_VICIVLE_FAINAR: '',
            h_VICIVLE_FAITHAIY: '',
            h_VICIVLE_FAIYKHANG: '',
            h_VICIVLE_VENMONGNAR: '',
            h_VICIVLE_VENMONGLHG: '',
            h_VICIVLE_VENKHANG: '',
            h_LEK_NUMMUNKHG: '',
            kim_KM: '',
            h_STATUS: '',
            r_TIRE_NO_1: '',
            r_TIRE_NO_2: '',
            r_TIRE_NO_3: '',
            r_TIRE_NO_4: '',
            r_TIRE_NO_5: '',
            r_TIRE_NO_6: '',
            r_TIRE_DATE_1: '',
            r_TIRE_DATE_2: '',
            r_TIRE_DATE_3: '',
            r_TIRE_DATE_4: '',
            r_TIRE_DATE_5: '',
            r_TIRE_DATE_6: '',
            r_TIRE_KM_1: '',
            r_TIRE_KM_2: '',
            r_TIRE_KM_3: '',
            r_TIRE_KM_4: '',
            r_TIRE_KM_5: '',
            r_TIRE_KM_6: '',
            ll_TIRE_NO_1: '',
            ll_TIRE_NO_2: '',
            ll_TIRE_NO_5: '',
            ll_TIRE_KM_1: '',
            ll_TIRE_NO_4: '',
            ll_TIRE_DATE_1: '',
            ll_TIRE_DATE_3: '',
            ll_TIRE_DATE_5: '',
            ll_TIRE_KM_2: '',
            ll_TIRE_NO_3: '',
            ll_TIRE_NO_6: '',
            ll_TIRE_DATE_2: '',
            ll_TIRE_KM_3: '',
            ll_TIRE_DATE_6: '',
            ll_TIRE_DATE_4: '',
            ll_TIRE_KM_6: '',
            ll_TIRE_KM_4: '',
            ll_TIRE_KM_5: '',
            //left last and now
            h_KM1: '',
            h_KM2: '',
            h_KM3: '',
            h_KM4: '',
            h_KM5: '',
            h_KM6: '',
            h_KM7: '',
            h_KM8: '',
            h_KM9: '',
            h_KM10: '',
            h_KM11: '',
            h_KM12: '',
            //right last and now
            h_KML_1: '',
            h_KML_2: '',
            h_KML_3: '',
            h_KML_4: '',
            h_KML_5: '',
            h_KML_6: '',
            h_KML_7: '',
            h_KML_8: '',
            h_KML_9: '',
            h_KML_10: '',
            h_KML_11: '',
            h_KML_12: ''

        }
    },
    watch: {
        h_LEK_NUMMUNKHG: function (value) {
            if (parseFloat(value?.split(',').join('')) <= parseFloat(this.kim_KM?.split(',').join(''))) {
                this.alert = true
            } else {
                this.alert = false
            }
        },
        kim_KM: function (value) {
            if (parseFloat(value?.split(',').join('')) >= parseFloat(this.h_LEK_NUMMUNKHG?.split(',').join(''))) {
                this.alert = true
            } else {
                this.alert = false
            }
        }
    },
    mounted() {
        // console.log(this.$router.params.foo)
        if (this.$route.query.key) {
            this.ongetData()
        }
    },
    methods: {
        async ongetData() {
            try {
                // this.loading_processing = true;
                await this.$axios.$post('/listVicicleHeaderByID.service', { key_id: this.$route.query.key }).then((data) => {
                    // this.loading_processing = false;
                    console.log("dataUpd", data)
                    this.h_STATUS = data?.data[0]?.h_STATUS;
                    this.kim_KM = data?.data[0]?.kim_KM,
                        this.h_LEK_NUMMUNKHG = data?.data[0]?.h_LEK_NUMMUNKHG,
                        this.h_VICIVLE_GLASS = data?.data[0]?.h_VICIVLE_GLASS,
                        this.h_VICIVLE_NUMBER = data?.data[0]?.h_VICIVLE_NUMBER,
                        this.h_VICIVLE_GALATY = data?.data[0]?.h_VICIVLE_GALATY,
                        this.h_VICIVLE_DATE_GALATY = data?.data[0]?.h_VICIVLE_DATE_GALATY,
                        this.h_VICIVLE_TNGLOD = data?.data[0]?.h_VICIVLE_TNGLOD,
                        this.h_VICIVLE_BRANCH = data?.data[0]?.h_VICIVLE_BRANCH,
                        this.h_VICIVLE_YEARLEVEL = data?.data[0]?.h_VICIVLE_YEARLEVEL,
                        this.h_VICIVLE_BRANCHTYPE = data?.data[0]?.h_VICIVLE_BRANCHTYPE,
                        this.h_VICIVLE_DATEEXPRIRE = data?.data[0]?.h_VICIVLE_DATEEXPRIRE,
                        this.h_VICIVLE_LEKJUK = data?.data[0]?.h_VICIVLE_LEKJUK,
                        this.h_VICIVLE_LEKTHUNG = data?.data[0]?.h_VICIVLE_LEKTHUNG,
                        this.h_VICIVLE_GPS = data?.data[0]?.h_VICIVLE_GPS,
                        this.h_VICIVLE_POYPUDNUMFON = data?.data[0]?.h_VICIVLE_POYPUDNUMFON,
                        this.h_VICIVLE_MORFAI = data?.data[0]?.h_VICIVLE_MORFAI,
                        this.h_VICIVLE_BGTOM = data?.data[0]?.h_VICIVLE_BGTOM,
                        this.h_VICIVLE_JANLARK = data?.data[0]?.h_VICIVLE_JANLARK,
                        this.h_VICIVLE_FAINAR = data?.data[0]?.h_VICIVLE_FAINAR,
                        this.h_VICIVLE_FAITHAIY = data?.data[0]?.h_VICIVLE_FAITHAIY,
                        this.h_VICIVLE_FAIYKHANG = data?.data[0]?.h_VICIVLE_FAIYKHANG,
                        this.h_VICIVLE_VENMONGNAR = data?.data[0]?.h_VICIVLE_VENMONGNAR,
                        this.h_VICIVLE_VENMONGLHG = data?.data[0]?.h_VICIVLE_VENMONGLHG,
                        this.h_VICIVLE_VENKHANG = data?.data[0]?.h_VICIVLE_VENKHANG,
                        this.r_TIRE_NO_1 = data?.data[0]?.r_TIRE_NO_1,
                        this.r_TIRE_NO_2 = data?.data[0]?.r_TIRE_NO_2,
                        this.r_TIRE_NO_3 = data?.data[0]?.r_TIRE_NO_3,
                        this.r_TIRE_NO_4 = data?.data[0]?.r_TIRE_NO_4,
                        this.r_TIRE_NO_5 = data?.data[0]?.r_TIRE_NO_5,
                        this.r_TIRE_NO_6 = data?.data[0]?.r_TIRE_NO_6,
                        this.r_TIRE_DATE_1 = data?.data[0]?.r_TIRE_DATE_1,
                        this.r_TIRE_DATE_2 = data?.data[0]?.r_TIRE_DATE_2,
                        this.r_TIRE_DATE_3 = data?.data[0]?.r_TIRE_DATE_3,
                        this.r_TIRE_DATE_4 = data?.data[0]?.r_TIRE_DATE_4,
                        this.r_TIRE_DATE_5 = data?.data[0]?.r_TIRE_DATE_5,
                        this.r_TIRE_DATE_6 = data?.data[0]?.r_TIRE_DATE_6,
                        this.r_TIRE_KM_1 = data?.data[0]?.r_TIRE_KM_1,
                        this.r_TIRE_KM_2 = data?.data[0]?.r_TIRE_KM_2,
                        this.r_TIRE_KM_3 = data?.data[0]?.r_TIRE_KM_3,
                        this.r_TIRE_KM_4 = data?.data[0]?.r_TIRE_KM_4,
                        this.r_TIRE_KM_5 = data?.data[0]?.r_TIRE_KM_5,
                        this.r_TIRE_KM_6 = data?.data[0]?.r_TIRE_KM_6,
                        this.ll_TIRE_NO_1 = data?.data[0]?.ll_TIRE_NO_1,
                        this.ll_TIRE_NO_2 = data?.data[0]?.ll_TIRE_NO_2,
                        this.ll_TIRE_NO_5 = data?.data[0]?.ll_TIRE_NO_5,
                        this.ll_TIRE_KM_1 = data?.data[0]?.ll_TIRE_KM_1,
                        this.ll_TIRE_NO_4 = data?.data[0]?.ll_TIRE_NO_4,
                        this.ll_TIRE_DATE_1 = data?.data[0]?.ll_TIRE_DATE_1,
                        this.ll_TIRE_DATE_3 = data?.data[0]?.ll_TIRE_DATE_3,
                        this.ll_TIRE_DATE_5 = data?.data[0]?.ll_TIRE_DATE_5,
                        this.ll_TIRE_KM_2 = data?.data[0]?.ll_TIRE_KM_2,
                        this.ll_TIRE_NO_3 = data?.data[0]?.ll_TIRE_NO_3,
                        this.ll_TIRE_NO_6 = data?.data[0]?.ll_TIRE_NO_6,
                        this.ll_TIRE_DATE_2 = data?.data[0]?.ll_TIRE_DATE_2,
                        this.ll_TIRE_KM_3 = data?.data[0]?.ll_TIRE_KM_3,
                        this.ll_TIRE_DATE_6 = data?.data[0]?.ll_TIRE_DATE_6,
                        this.ll_TIRE_DATE_4 = data?.data[0]?.ll_TIRE_DATE_4,
                        this.ll_TIRE_KM_6 = data?.data[0]?.ll_TIRE_KM_6,
                        this.ll_TIRE_KM_4 = data?.data[0]?.ll_TIRE_KM_4,
                        this.ll_TIRE_KM_5 = data?.data[0]?.ll_TIRE_KM_5,
                        this.h_KM1 = data?.data[0]?.h_KM1,
                        this.h_KM2 = data?.data[0]?.h_KM2,
                        this.h_KM3 = data?.data[0]?.h_KM3,
                        this.h_KM4 = data?.data[0]?.h_KM4,
                        this.h_KM5 = data?.data[0]?.h_KM5,
                        this.h_KM6 = data?.data[0]?.h_KM6,
                        this.h_KM7 = data?.data[0]?.h_KM7,
                        this.h_KM8 = data?.data[0]?.h_KM8,
                        this.h_KM9 = data?.data[0]?.h_KM9,
                        this.h_KM10 = data?.data[0]?.h_KM10,
                        this.h_KM11 = data?.data[0]?.h_KM11,
                        this.h_KM12 = data?.data[0]?.h_KM12,
                        //right last and now
                        this.h_KML_1 = data?.data[0]?.h_KML_1,
                        this.h_KML_2 = data?.data[0]?.h_KML_2,
                        this.h_KML_3 = data?.data[0]?.h_KML_3,
                        this.h_KML_4 = data?.data[0]?.h_KML_4,
                        this.h_KML_5 = data?.data[0]?.h_KML_5,
                        this.h_KML_6 = data?.data[0]?.h_KML_6,
                        this.h_KML_7 = data?.data[0]?.h_KML_7,
                        this.h_KML_8 = data?.data[0]?.h_KML_8,
                        this.h_KML_9 = data?.data[0]?.h_KML_9,
                        this.h_KML_10 = data?.data[0]?.h_KML_10,
                        this.h_KML_11 = data?.data[0]?.h_KML_11,
                        this.h_KML_12 = data?.data[0]?.h_KML_12

                })
            } catch (error) {
                swal.fire({
                    icon: 'error',
                    text: error
                })
                this.loading_processing = false
                console.log(error)
            }
        },

    },
}
</script>
<style lang="scss">
.margintop {
    margin-top: -30px;
}

.top {
    margin-top: 5px;
    margin-left: 10px;
}

.centers {
    justify-content: center;
    background-color: red;
    justify-items: center;
}</style>
  