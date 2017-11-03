package egovframework.example.adminProduct.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.example.adminProduct.service.AdminProductService;
import egovframework.example.adminProduct.service.AdminProductVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("adminProductService")
public class AdminProductServiceImpl extends EgovAbstractServiceImpl implements AdminProductService{
	
	@Resource(name = "adminProductMapper")
	private AdminProductMapper adminProductMapper;

	@SuppressWarnings("rawtypes")
	@Override
	public List<Map> selectGetCosList() throws Exception {

		return adminProductMapper.selectGetCosList();
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public List<Map> jqgridAdminProList(AdminProductVO adminProductVO)
			throws Exception {
		
		return adminProductMapper.jqgridAdminProList(adminProductVO);
	}

	@Override
	public EgovMap selectAdminProdCnt(AdminProductVO adminProductVO)
			throws Exception {

		return adminProductMapper.selectAdminProdCnt(adminProductVO);
	}

	@Transactional(rollbackFor=Exception.class)
	@Override
	public void saveAdminProduct(Map<String, Object> castMap) throws Exception {
		
		/* 시작일과 종료일형식 변환  */
		String getStartDay = castMap.get("productStartDay").toString().replaceAll("/ ", "-");
		String getEndDay = castMap.get("productEndDay").toString().replaceAll("/ ", "-");
		String[] productTime = null;
		
		if (castMap.get("productTime").toString().contains(",")) {
			productTime = castMap.get("productTime").toString().split(",");
		}
		
		try {

			/* 시작일과 종료일 사이 날짜 구하기 */
			SimpleDateFormat setData = new SimpleDateFormat("yyyy-MM-dd");
			
			Date startDay = setData.parse(getStartDay);
			Date endDay = setData.parse(getEndDay);

			int oneDay = (24 * 60 * 60 * 1000);
			
			Long getDay = endDay.getTime() - Math.abs(startDay.getTime());
			Long getDays = getDay / oneDay;
			Long today = startDay.getTime();
			
			Long getProdDay = null;
			String productStartDay = "";
			
			try {

				/* 시작일과 종료일 사이 기간만큼 인서트문을 반복 */
				for (int i = 0; i < getDays + 1; i++) {
					getProdDay = today + (oneDay * i);

					productStartDay = setData.format(getProdDay);

					castMap.replace("productStartDay", productStartDay);
					
					try {

						/* 출발시간이 여러개일경우 */
						if (productTime != null) {
							
							for (int j = 0; j < productTime.length; j++) {
								castMap.replace("productTime", productTime[j]);
								
								adminProductMapper.saveAdminProduct(castMap);
							}
						} else {
							adminProductMapper.saveAdminProduct(castMap);
						}
						
					} catch (Exception e) {
						throw e;
					}
				}
			} catch (Exception e) {
				throw e;
			}
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public EgovMap selectGetCosNum(Map<String, Object> castMap)
			throws Exception {

		return adminProductMapper.selectGetCosNum(castMap);
	}

	@Override
	public EgovMap selectGetTime(Map<String, Object> resMap) throws Exception {

		return adminProductMapper.selectGetTime(resMap);
	}

	/* 행삭제  */
	@Override
	public void deletAdminProduct(String quotZero) throws Exception {

		String[] getProdNum = quotZero.toString().split(",");
		
		String prodNum = "";
		try {

			for (int i = 0; i < getProdNum.length; i++) {
				
				prodNum = getProdNum[i].toString();
				
				adminProductMapper.deletAdminProduct(prodNum);
			}
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public EgovMap selectGetTotal(Map<String, Object> resMap) throws Exception {

		return adminProductMapper.selectGetTotal(resMap);
	}

	@Override
	public EgovMap selectGetBusSeat(String param1) throws Exception {

		return adminProductMapper.selectGetBusSeat(param1);
	}
}