<#macro kw>
  <div class=" min-h-screen sm:py-0 flex items-center justify-center items-center";background-size: cover;">
    <div class="w-fit flex justify-center items-center w-full p-5 relative mx-auto my-auto rounded-xl shadow-lg bg-white" style="width: auto;padding: 49px;">
      <div class="items-center justify-center flex space-between" style="position: relative;display: flex;height: 100%;>
        <div class="text-center" style="display: flex;justify-content: center;">
            <img src="${url.resourcesPath}/img/LOGO5.png"alt="login illustration"style="width: 70%; height:100%;">
        </div>
        <div class="space-y-6 w-full ">
          <#nested>
        </div>
      </div>
    </div>
  </div>
</#macro>
